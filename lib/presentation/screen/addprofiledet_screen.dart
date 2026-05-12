import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/homepage_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  String? selectedCity;

  List<String> cities = [
    "دمشق",
    "حلب",
    "حمص",
    "حماة",
    "اللاذقية",
    "طرطوس",
    "درعا",
    "السويداء",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 100),

              Container(
                width: double.infinity,

                decoration: const BoxDecoration(color: Colors.white),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(
                      "الملف الشخصي",

                      style: GoogleFonts.cairo(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "الرجاء إكمال إدخال معلوماتك الشخصية",

                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        color: AppColors.naturalgray,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 🔹 رقم الهوية
                    TextField(
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: "رقم الهوية",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        prefixIcon: const Icon(Icons.badge),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 رقم السجل التجاري
                    TextField(
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: "رقم السجل التجاري",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        prefixIcon: const Icon(Icons.business),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 المحافظة
                    DropdownButtonFormField<String>(
                      value: selectedCity,

                      decoration: InputDecoration(
                        labelText: "المحافظة",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        prefixIcon: const Icon(Icons.location_city),
                      ),

                      items: cities.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // 🔹 العنوان الحالي
                    TextField(
                      maxLines: 2,

                      decoration: InputDecoration(
                        labelText: "العنوان الحالي",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        prefixIcon: const Icon(Icons.location_on),
                      ),
                    ),

                    const SizedBox(height: 10),

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

                    const SizedBox(height: 60),

                    // 🔹 زر التسجيل
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainHomeScreen(),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),

                        backgroundColor: AppColors.mainblue,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: Text(
                        "تسجيل",

                        style: GoogleFonts.cairo(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
