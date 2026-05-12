import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/Otp_screen.dart';
import 'package:goods_delivery_app/presentation/screen/logIn_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 130, left: 40),
                      child: Image.asset(
                        "assets/images/Truck.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 40),
                      child: Image.asset(
                        "assets/images/maptwoconnect.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,

              decoration: BoxDecoration(color: Colors.white),

              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "إنشاء حساب",
                      style: GoogleFonts.cairo(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // رقم الهاتف
                    TextField(
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        labelText: "الأسم الكامل",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    // كلمة المرور
                    TextField(
                      obscureText: isPasswordHidden,

                      decoration: InputDecoration(
                        labelText: "رقم الهاتف",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "سياسة الخصوصية والشروط والأحكام",
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: AppColors.yallow,
                          ),
                        ),
                        Text(
                          "الموافقة على",
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: AppColors.naturalgray,
                          ),
                        ),
                        Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green,
                          size: 15,
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => OtpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: AppColors.mainblue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "إنشاء حساب ",
                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "تسجيل الدخول",
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightblue,
                            ),
                          ),
                        ),
                        Text(
                          "لديك حساب مسبقاً؟",
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
          ],
        ),
      ),
    );
  }
}
