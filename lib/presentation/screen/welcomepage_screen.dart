import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/screen/logIn_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // 1. الصورة الخلفية
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/welcomepage.png",
              fit: BoxFit.cover,
            ),
          ),
          // 2. طبقة شفافة (اختياري لتحسين وضوح النص)
          Container(color: Colors.black.withOpacity(0.4)),

          // 3. المحتوى فوق الصورة
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "شحن آمن في ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "متناول يديك",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "مستعدون لشحن بضائعك إلى أي مكان تريده",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 150,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      "لنبدأ",
                      style: TextStyle(color: AppColors.black, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
