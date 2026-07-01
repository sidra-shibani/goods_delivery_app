import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit/signUp_cubit.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';

import 'package:goods_delivery_app/helper/core/SharedPreferencesHelper.dart';
import 'package:goods_delivery_app/presentation/screen/homepage_screen.dart';
import 'package:goods_delivery_app/presentation/screen/Auth/resetpassword_screen.dart';

import 'package:goods_delivery_app/presentation/screen/Auth/signupFlow.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),

      child: BlocListener<LoginCubit, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoadedLogin) {
            final token = state.response.data.accessToken;
            final username = state.response.data.username;
            //final phone = state.response.data.phone;
            await SharedPreferencesHelper.saveToken(token);

            if (username != null) {
              await SharedPreferencesHelper.saveName(username);
              //  await SharedPreferencesHelper.savePhone(phone);
            }

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MainHomeScreen()),
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: AppColors.white,
            resizeToAvoidBottomInset: false,

            body: SafeArea(
              child: Builder(
                builder: (formContext) {
                  final cubit = formContext.read<LoginCubit>();

                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/secondpage.png",
                          fit: BoxFit.cover,
                        ),
                      ),

                      Expanded(
                        child: Transform.translate(
                          offset: Offset(0, -30),

                          child: Container(
                            width: double.infinity,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),

                            child: Padding(
                              padding: const EdgeInsets.all(20),

                              child: Form(
                                key: cubit.formkey,

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),

                                    Text(
                                      "مرحباً",
                                      style: GoogleFonts.cairo(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text(
                                      "يرجى إدخال بياناتك قبل الدخول",
                                      style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        color: AppColors.naturalgray,
                                      ),
                                    ),

                                    SizedBox(height: 30),

                                    // رقم الهاتف
                                    TextFormField(
                                      controller: cubit.phoneController,
                                      textDirection: TextDirection.ltr,
                                      keyboardType: TextInputType.phone,

                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "يرجى إدخال رقم الهاتف";
                                        }

                                        if (value.length < 9) {
                                          return "رقم الهاتف غير صالح";
                                        }

                                        return null;
                                      },

                                      decoration: InputDecoration(
                                        labelText: "رقم الهاتف",

                                        hintText: "9XXXXXXXX",

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),

                                        prefixIcon: const Icon(Icons.phone),

                                        prefixText: "+963 ",
                                        prefixStyle: GoogleFonts.cairo(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20),

                                    // كلمة المرور
                                    TextFormField(
                                      controller: cubit.passwordController,

                                      obscureText: isPasswordHidden,

                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "يرجى إدخال كلمة المرور";
                                        }
                                        return null;
                                      },

                                      decoration: InputDecoration(
                                        labelText: "كلمة المرور",

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                              isPasswordHidden =
                                                  !isPasswordHidden;
                                            });
                                          },
                                        ),
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,

                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPasswordScreen(),
                                          ),
                                        );
                                      },

                                      child: Text(
                                        "نسيت كلمة المرور؟",

                                        style: GoogleFonts.cairo(
                                          fontSize: 16,
                                          color: AppColors.mainblue,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30),

                                    BlocBuilder<LoginCubit, AuthState>(
                                      builder: (context, state) {
                                        if (state is AuthLoading) {
                                          return ElevatedButton(
                                            onPressed: null,

                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                double.infinity,
                                                50,
                                              ),

                                              backgroundColor:
                                                  AppColors.mainblue,

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),

                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          );
                                        }

                                        return ElevatedButton(
                                          onPressed: () {
                                            if (cubit.formkey.currentState!
                                                .validate()) {
                                              cubit.login(
                                                "+963${cubit.phoneController.text.trim()}",

                                                cubit.passwordController.text
                                                    .trim(),
                                              );
                                            }
                                          },

                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(
                                              double.infinity,
                                              50,
                                            ),

                                            backgroundColor: AppColors.mainblue,

                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),

                                          child: Text(
                                            "تسجيل الدخول",

                                            style: GoogleFonts.cairo(
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,

                                      children: [
                                        Text(
                                          "ليس لديك حساب؟",

                                          style: GoogleFonts.cairo(
                                            fontSize: 16,

                                            color: AppColors.naturalgray,
                                          ),
                                        ),

                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => BlocProvider(
                                                  create: (context) =>
                                                      SignUpCubit(
                                                        context
                                                            .read<
                                                              AuthRepository
                                                            >(),
                                                      ),
                                                  child: SignupFlow(),
                                                ),
                                              ),
                                            );
                                          },

                                          child: Text(
                                            "سجل هنا",

                                            style: GoogleFonts.cairo(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,

                                              color: AppColors.mainblue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
