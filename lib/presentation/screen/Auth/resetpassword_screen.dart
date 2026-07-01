import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: Column(
          children: [
            // 🔹 الصور العلوية
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

            // 🔹 المحتوى
            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(color: Colors.white),

                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text(
                        "إنشاء كلمة مرور جديدة",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "قم بإدخال كلمة المرور الجديدة",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.naturalgray,
                        ),
                      ),

                      SizedBox(height: 40),

                      // 🔹 كلمة المرور
                      TextField(
                        obscureText: isPasswordHidden,

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
                      TextField(
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

                      SizedBox(height: 40),

                      // 🔹 زر الحفظ
                      ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),

                          backgroundColor: AppColors.mainblue,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: Text(
                          "حفظ كلمة المرور",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
