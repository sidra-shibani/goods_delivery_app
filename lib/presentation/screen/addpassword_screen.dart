import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/addprofiledet_screen.dart';

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
      resizeToAvoidBottomInset: false,

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100),
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
                        "إدخال كلمة مرور ",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "قم بإدخال كلمة مرور ",
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "على الأقل 8 أحرف",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.naturalgray,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 60),

                      // 🔹 زر الحفظ
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProfileScreen(),
                            ),
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
                          "التالي",
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
