import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:goods_delivery_app/bussiness/Auth_cubit/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit/signUp_cubit.dart';
import 'package:goods_delivery_app/const/colors.dart';

import 'package:goods_delivery_app/presentation/screen/Auth/addprofiledet_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreenState();
}

class _AddPasswordScreenState extends State<AddPasswordScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (formContext) {
              final signupCubit = formContext.read<SignUpCubit>();
              return Form(
                key: signupCubit.formkey2,

                child: Column(
                  children: [
                    SizedBox(height: 100),

                    Container(
                      width: double.infinity,

                      decoration: BoxDecoration(color: Colors.white),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(
                            "إدخال كلمة مرور ",
                            style: GoogleFonts.cairo(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            "قم بإدخال كلمة مرور ",
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              color: AppColors.naturalgray,
                            ),
                          ),

                          SizedBox(height: 40),

                          // 🔹 كلمة المرور
                          TextFormField(
                            obscureText: isPasswordHidden,
                            controller: signupCubit.passwordController,
                            textDirection: TextDirection.rtl,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى إدخال كلمة المرور";
                              }

                              if (value.length < 8) {
                                return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "كلمة المرور",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              prefixIcon: Icon(Icons.lock),

                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),

                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // 🔹 تأكيد كلمة المرور
                          TextFormField(
                            controller: signupCubit.passwordConController,
                            textDirection: TextDirection.rtl,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى تأكيد كلمة المرور";
                              }

                              if (value !=
                                  signupCubit.passwordController.text) {
                                return "كلمتا المرور غير متطابقتين";
                              }

                              return null;
                            },
                            obscureText: isConfirmPasswordHidden,

                            decoration: InputDecoration(
                              labelText: "تأكيد كلمة المرور",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              prefixIcon: Icon(Icons.lock),

                              suffixIcon: IconButton(
                                icon: Icon(
                                  isConfirmPasswordHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),

                                onPressed: () {
                                  setState(() {
                                    isConfirmPasswordHidden =
                                        !isConfirmPasswordHidden;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "على الأقل 8 أحرف",
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  color: AppColors.naturalgray,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 60),

                          // 🔹 زر الحفظ
                          BlocBuilder<SignUpCubit, AuthState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (signupCubit.formkey2.currentState!
                                      .validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<SignUpCubit>(),
                                          child: AddProfileScreen(),
                                        ),
                                      ),
                                    );
                                  }
                                },

                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 50),

                                  backgroundColor: AppColors.mainblue,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                child: Text(
                                  "التالي",
                                  style: GoogleFonts.cairo(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
