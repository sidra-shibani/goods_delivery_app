import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit/signUp_cubit.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/model/otp_model.dart';
import 'package:goods_delivery_app/presentation/screen/Auth/addpassword_screen.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,

      body: BlocConsumer<SignUpCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadedSendOtp) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تمت إعادة إرسال رمز التحقق")),
            );
          }

          if (state is AuthLoadedVerOtp) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<SignUpCubit>(),
                  child: const AddPasswordScreen(),
                ),
              ),
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final signupCubit = context.read<SignUpCubit>();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),

                  // 🔹 صورة أو أيقونة
                  // Icon(Icons.sms_outlined, size: 90, color: AppColors.mainblue),
                  SizedBox(height: 30),

                  // 🔹 العنوان
                  Text(
                    "تأكيد رقم الهاتف",
                    style: GoogleFonts.cairo(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "أدخل رمز التحقق المرسل إلى رقم هاتفك",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      color: AppColors.naturalgray,
                    ),
                  ),

                  SizedBox(height: 50),

                  Pinput(
                    controller: signupCubit.otpController,
                    length: 6,
                    keyboardType: TextInputType.number,

                    defaultPinTheme: PinTheme(
                      width: 55,
                      height: 60,
                      textStyle: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    focusedPinTheme: PinTheme(
                      width: 55,
                      height: 60,
                      textStyle: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.mainblue, width: 2),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          signupCubit.otpSend(
                            SendOtpRequest(
                              phoneNumber:
                                  "+963${signupCubit.phoneController.text.trim()}",
                            ),
                          );
                        },

                        child: Text(
                          "إعادة الإرسال",
                          style: GoogleFonts.cairo(
                            color: AppColors.yallow,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "يمكن إعادة ارسال الرمز",
                        style: GoogleFonts.cairo(color: AppColors.naturalgray),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  // 🔹 زر التحقق
                  ElevatedButton(
                    onPressed: () {
                      signupCubit.otpVer(
                        VerifyOtpRequest(
                          phoneNumber:
                              "+963${signupCubit.phoneController.text.trim()}",
                          otp: signupCubit.otpController.text.trim(),
                        ),
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55),
                      backgroundColor: AppColors.mainblue,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    child: Text(
                      "تأكيد",
                      style: GoogleFonts.cairo(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
