import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/addpassword_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,

      body: SafeArea(
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

              // 🔥 OTP BOXES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) => SizedBox(
                    width: 55,
                    height: 60,

                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,

                      style: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),

                      decoration: InputDecoration(
                        counterText: "",

                        filled: true,
                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: AppColors.mainblue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},

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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPasswordScreen(),
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

              // 🔹 إعادة الإرسال
            ],
          ),
        ),
      ),
    );
  }
}
