import 'package:flutter/material.dart';
import 'package:goods_delivery_app/presentation/screen/logIn_screen.dart';
import 'package:goods_delivery_app/presentation/screen/welcomepage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const MyHomePage(),
    );
  }
}
