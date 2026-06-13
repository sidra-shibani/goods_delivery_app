import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/create_ship_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/price_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../const/colors.dart';
import 'truck_size_screen.dart';

class TruckTypeScreen extends StatefulWidget {
  const TruckTypeScreen({super.key});

  @override
  State<TruckTypeScreen> createState() => _TruckTypeScreenState();
}

class _TruckTypeScreenState extends State<TruckTypeScreen> {
  String? selectedTruck;

  @override
  Widget build(BuildContext context) {
    final createshipCubit = context.read<CreateShipCubit>();

    final pricecubit = context.read<PriceCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        centerTitle: true,

        title: Text(
          "طلب جديد",
          style: GoogleFonts.cairo(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 30),

            Text(
              "اختر نوع الشاحنة المناسبة",

              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,

                children: [
                  _truckCard(
                    context,
                    "مغلقة",
                    "assets/images/truck-closed.png",
                  ),

                  _truckCard(context, "مفتوحة", "assets/images/truck_open.png"),

                  _truckCard(
                    context,
                    "براد",
                    "assets/images/food truck-ref.png",
                  ),
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: AppColors.mainblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: selectedTruck == null
                    ? null
                    : () {
                        print(
                          "نوع الشاحنة المختار : ${createshipCubit.truckTypeController.text}",
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                TruckSizeScreen(truckType: selectedTruck!),
                          ),
                        );
                      },

                child: Text(
                  "التالي",
                  style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _truckCard(BuildContext context, String title, String image) {
    final createshipCubit = context.read<CreateShipCubit>();
    final pricecubit = context.read<PriceCubit>();
    bool selected = selectedTruck == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTruck = title;
        });

        switch (title) {
          case "مغلقة":
            createshipCubit.truckTypeController.text = "closed";
            pricecubit.truckTypeController.text = "closed";
            break;

          case "مفتوحة":
            createshipCubit.truckTypeController.text = "open";
            pricecubit.truckTypeController.text = "open";
            break;

          case "براد":
            createshipCubit.truckTypeController.text = "refrigerated";
            pricecubit.truckTypeController.text = "refrigerated";
            break;
        }
      },

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightyallow,

          borderRadius: BorderRadius.circular(10),

          border: Border.all(
            color: selected ? AppColors.yallow : Colors.transparent,
            width: 2,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(image, height: 70),

            const SizedBox(height: 10),

            Text(
              title,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
