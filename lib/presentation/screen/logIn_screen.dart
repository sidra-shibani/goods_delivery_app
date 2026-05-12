import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/resetpassword_screen.dart';
import 'package:goods_delivery_app/presentation/screen/signUp_Screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  bool isPasswordHidden = true;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                        TextField(
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            labelText: "رقم الهاتف",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),

                        SizedBox(height: 20),

                        // كلمة المرور
                        TextField(
                          obscureText: isPasswordHidden,

                          decoration: InputDecoration(
                            labelText: "كلمة المرور",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPasswordScreen(),
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

                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            backgroundColor: AppColors.mainblue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "تسجيل الدخول",
                            style: GoogleFonts.cairo(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
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
                            Text(
                              "ليس لديك حساب؟",
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                color: AppColors.naturalgray,
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
          ],
        ),
      ),
    );
  }
}
