import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/Data/truck_data.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/create_ship_cubit.dart';
import 'package:goods_delivery_app/datasource/model/truck_size_model.dart';
import 'package:goods_delivery_app/presentation/screen/shipment/AdditionalInfoScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/colors.dart';

class TruckSizeScreen extends StatefulWidget {
  final String truckType;

  const TruckSizeScreen({super.key, required this.truckType});

  @override
  State<TruckSizeScreen> createState() => _TruckSizeScreenState();
}

class _TruckSizeScreenState extends State<TruckSizeScreen> {
  TruckSizeModel? selectedSize;

  late List<TruckSizeModel> sizes;

  @override
  void initState() {
    super.initState();

    if (widget.truckType.trim() == "مغلقة") {
      sizes = TruckData.closedTruck;
    } else if (widget.truckType == "مفتوحة") {
      sizes = TruckData.openTruck;
    } else {
      sizes = TruckData.refrigeratedTruck;
    }
  }

  @override
  Widget build(BuildContext context) {
    final createshipCubit = context.read<CreateShipCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,

        centerTitle: true,

        title: Text(
          "طلب جديد",
          style: GoogleFonts.cairo(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 40),

            Text(
              "اختر الحجم المناسب للشاحنة",

              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 140,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: sizes.length,

                itemBuilder: (context, index) {
                  final size = sizes[index];

                  bool selected = selectedSize == size;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });

                      createshipCubit.trucksizeController.text = size.name;
                    },

                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.only(left: 10),

                      decoration: BoxDecoration(
                        color: const Color(0xffF8F3D7),

                        borderRadius: BorderRadius.circular(10),

                        border: Border.all(
                          color: selected
                              ? AppColors.yallow
                              : AppColors.yallow.withOpacity(.4),
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset(
                            size.image,
                            height: 55,
                            fit: BoxFit.contain,
                          ),

                          const SizedBox(height: 10),

                          Text(
                            size.name,
                            style: GoogleFonts.cairo(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            if (selectedSize != null)
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(
                  color: Colors.grey.shade200,

                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    Text(
                      selectedSize!.name,
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      selectedSize!.description,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(
                        //fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "تبدأ من : ${selectedSize!.price}",
                      style: GoogleFonts.cairo(
                        //fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: selectedSize == null
                    ? null
                    : () {
                        print(
                          "نوع الشاحنة المختار : ${createshipCubit.trucksizeController.text}",
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdditionalInfoScreen(),
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
                  style: GoogleFonts.cairo(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
