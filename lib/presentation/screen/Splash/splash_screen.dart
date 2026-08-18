import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/helper/core/SharedPreferencesHelper.dart';
import 'package:goods_delivery_app/presentation/screen/homepage_screen.dart';
import 'package:goods_delivery_app/presentation/screen/onboarding/onboarding_screen.dart';
import 'package:goods_delivery_app/helper/core/service_locator.dart';
import 'package:goods_delivery_app/notifications/repo/notification_repo.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _logoAnimation = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _textAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 20));

    final token = await SharedPreferencesHelper.getToken();
    //TODO: call fetch and update function from notifiction repo
    if (!mounted) return;

    // المستخدم مسجل دخول
    if (token != null) {
      sl<NotificationRepo>().fetchAndSendFcmToken();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainHomeScreen()),
      );
      return;
    }

    // ليس مسجل دخول
    bool finished = await SharedPreferencesHelper.isOnboardingFinished();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => finished ? LoginScreen() : const OnBoardingPage(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainblue,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
                      "حُمولَة",
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
                      "توصيل سريع آمن",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 55,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.8,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Loading...",
                    style: GoogleFonts.cairo(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
