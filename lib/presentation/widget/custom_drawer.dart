import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_cubit.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_state.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/helper/core/SharedPreferencesHelper.dart';
import 'package:goods_delivery_app/presentation/screen/Auth/logIn_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Widget _buildTile(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.naturalgray),
          title: Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          onTap: onTap,
        ),
        const Divider(height: 1, color: AppColors.medgray),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,

      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(100),
          bottomRight: Radius.circular(90),
        ),
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.person, size: 30, color: Colors.black),
                    ),

                    const SizedBox(height: 10),

                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is GetProfileLoaded) {
                          final user = state.me.data;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                user.phoneNumber,
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          );
                        }

                        if (state is ProfileLoading) {
                          return Text(
                            "جاري التحميل...",
                            style: GoogleFonts.cairo(fontSize: 14),
                          );
                        }

                        return Text(
                          "المستخدم",
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  children: [
                    _buildTile(Icons.person, "الملف الشخصي", () {}),
                    _buildTile(Icons.wallet, "المحفظة", () {}),
                    _buildTile(Icons.history, "طلباتي السابقة", () {}),
                    _buildTile(Icons.discount, "كود خصم", () {}),
                    _buildTile(Icons.settings, "الإعدادات", () {}),
                    _buildTile(Icons.notifications, "الإشعارات", () {}),
                    _buildTile(Icons.phone, "تواصل معنا", () {}),

                    _buildTile(Icons.logout, "تسجيل الخروج", () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: Text(
                            "هل أنت متأكد من تسجيل الخروج؟",
                            style: GoogleFonts.cairo(fontSize: 14),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: Text("لا", style: GoogleFonts.cairo()),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(ctx).pop();

                                await SharedPreferencesHelper.deleteToken();

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                "نعم",
                                style: GoogleFonts.cairo(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
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
