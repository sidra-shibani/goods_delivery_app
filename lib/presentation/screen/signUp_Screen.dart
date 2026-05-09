import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/Otp_screen.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/Truck.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 60),
                  Expanded(
                    child: Image.asset(
                      "assets/images/maptwoconnect.png",
                      fit: BoxFit.cover,
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
                      style: TextStyle(
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
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.yallow,
                          ),
                        ),
                        Text(
                          "الموافقة على",
                          style: TextStyle(
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
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightblue,
                            ),
                          ),
                        ),
                        Text(
                          "لديك حساب مسبقاً؟",
                          style: TextStyle(
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
