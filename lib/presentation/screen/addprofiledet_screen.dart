import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';

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
                        "الملف الشخصي",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "الرجاء إكمال إدخال معلوماتك الشخصية",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.naturalgray,
                        ),
                      ),

                      SizedBox(height: 40),
                      // 🔹 رقم الهوية
                      TextField(
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          labelText: "رقم الهوية",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          prefixIcon: Icon(Icons.badge),
                        ),
                      ),

                      SizedBox(height: 20),

                      // 🔹 رقم السجل التجاري
                      TextField(
                        keyboardType: TextInputType.number,

                        decoration: InputDecoration(
                          labelText: "رقم السجل التجاري",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          prefixIcon: Icon(Icons.business),
                        ),
                      ),

                      SizedBox(height: 20),

                      // 🔹 المحافظة
                      DropdownButtonFormField<String>(
                        value: selectedCity,

                        decoration: InputDecoration(
                          labelText: "المحافظة",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          prefixIcon: Icon(Icons.location_city),
                        ),

                        items: cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                      ),

                      SizedBox(height: 20),

                      // 🔹 العنوان الحالي
                      TextField(
                        maxLines: 2,

                        decoration: InputDecoration(
                          labelText: "العنوان الحالي",

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),

                          prefixIcon: Icon(Icons.location_on),
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
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),

                          backgroundColor: AppColors.mainblue,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: Text(
                          "تسجيل",
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
