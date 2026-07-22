import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_cubit.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_state.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المعلومات الشخصية",
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoaded) {
            final user = state.me.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.profilePictureUrl),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    user.fullName,
                    style: GoogleFonts.cairo(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    user.email,
                    style: GoogleFonts.cairo(color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  _InfoCard(
                    title: "المعلومات الأساسية",

                    children: [
                      _InfoRow(title: "الاسم", value: user.fullName),

                      _InfoRow(title: "البريد", value: user.email),

                      _InfoRow(title: "الهاتف", value: user.phoneNumber),
                    ],
                  ),

                  const SizedBox(height: 20),

                  if (user.merchantProfile != null)
                    _InfoCard(
                      title: "معلومات المتجر",

                      children: [
                        _InfoRow(
                          title: "الاسم التجاري",
                          value: user.merchantProfile!.fullName ?? "",
                        ),

                        _InfoRow(
                          title: "السجل التجاري",
                          value: user
                              .merchantProfile!
                              .commercialRegistrationNumber,
                        ),

                        _InfoRow(
                          title: "رقم الهوية",
                          value: user.merchantProfile!.idCardNumber,
                        ),

                        _InfoRow(
                          title: "العنوان",
                          value: user.merchantProfile!.address,
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  if (user.merchantProfile != null)
                    _InfoCard(
                      title: "التقييم",

                      children: [
                        _InfoRow(
                          title: "متوسط التقييم",

                          value:
                              user.merchantProfile!.ratingInfo!.averageRating
                                  ?.toString() ??
                              "لا يوجد",
                        ),

                        _InfoRow(
                          title: "عدد التقييمات",

                          value: user.merchantProfile!.ratingInfo!.totalRatings
                              .toString(),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }

          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Text("لا توجد بيانات", style: GoogleFonts.cairo()),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(15),

        border: Border.all(color: Colors.grey.shade300),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style: GoogleFonts.cairo(fontSize: 17, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(title, style: GoogleFonts.cairo(color: Colors.grey)),

          Flexible(
            child: Text(
              value,

              style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
