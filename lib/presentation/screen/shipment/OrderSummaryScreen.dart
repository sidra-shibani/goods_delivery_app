import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/create_ship_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/price_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../const/colors.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createShipCubit = context.read<CreateShipCubit>();

    return BlocListener<CreateShipCubit, ShipmentState>(
      listener: (context, state) {
        if (state is createShipLoaded) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/images/green_icon.png", height: 100),

                    const SizedBox(height: 15),

                    Text(
                      "تم تأكيد الطلب",
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "يتم الآن العثور على سائق مناسب\nالرجاء الانتظار",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),

                    CircularProgressIndicator(color: AppColors.mainblue),
                  ],
                ),
              );
            },
          );

          Future.delayed(const Duration(seconds: 10), () {
            Navigator.pop(context); // close dialog

            Navigator.popUntil(
              context,
              (route) => route.isFirst, // يرجع للهوم
            );
          });
          print("تم انشاء شحنة");
        } else if (state is ShipError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,

          centerTitle: true,

          title: Text(
            "مراجعة الطلب",
            style: GoogleFonts.cairo(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Row(
                        children: [
                          const Spacer(),

                          Text(
                            "عنوان التحميل",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(Icons.location_on, color: Colors.red),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          createShipCubit.pickupaddressController.text,
                          textAlign: TextAlign.right,

                          style: GoogleFonts.cairo(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          const Spacer(),

                          Text(
                            "عنوان الاستلام",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Icon(Icons.location_on, color: AppColors.yallow),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          createShipCubit.deliveryaddressController.text,
                          textAlign: TextAlign.right,

                          style: GoogleFonts.cairo(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "السعر",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "الخدمة ",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      //
                      BlocBuilder<PriceCubit, ShipmentState>(
                        builder: (context, state) {
                          if (state is GetPriceLoaded) {
                            final price = state.price.data;

                            final basicService =
                                price.distanceCharge +
                                price.startingFee +
                                price.weightSurcharge;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  padding: const EdgeInsets.all(16),

                                  decoration: BoxDecoration(
                                    color: AppColors.lightyallow,

                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.yallow,
                                      width: 2,
                                    ),
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ("${basicService.toStringAsFixed(2)} ل.س"),
                                        style: GoogleFonts.cairo(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          Text(
                                            createShipCubit
                                                .trucksizeNameController
                                                .text,

                                            style: GoogleFonts.cairo(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            createShipCubit
                                                        .truckTypeController
                                                        .text ==
                                                    "closed"
                                                ? "مغلقة"
                                                : createShipCubit
                                                          .truckTypeController
                                                          .text ==
                                                      "open"
                                                ? "مفتوحة"
                                                : createShipCubit
                                                          .truckTypeController
                                                          .text ==
                                                      "refrigerated"
                                                ? "براد"
                                                : createShipCubit
                                                      .truckTypeController
                                                      .text,
                                            style: GoogleFonts.cairo(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      createShipCubit.whoPays == "sender"
                                          ? "المرسل"
                                          : createShipCubit.whoPays ==
                                                "receiver"
                                          ? "المستلم"
                                          : createShipCubit.whoPays,
                                      style: GoogleFonts.cairo(
                                        color: Colors.grey.shade700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "الدافع",
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "تفاصيل إضافية",
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Divider(color: Colors.grey.shade300),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 30,
                                          ),
                                          child: Text(
                                            ("${price.refrigeratedSurcharge.toStringAsFixed(0)} ل.س"),
                                            textAlign: TextAlign.right,

                                            style: GoogleFonts.cairo(
                                              color: Colors.grey.shade700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "براد",
                                          textAlign: TextAlign.right,

                                          style: GoogleFonts.cairo(
                                            color: Colors.grey.shade700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ("${price.nightShippingSurcharge.toStringAsFixed(0)} ل.س"),
                                          textAlign: TextAlign.right,

                                          style: GoogleFonts.cairo(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 0,
                                          ),
                                          child: Text(
                                            "شحن ليلي",
                                            textAlign: TextAlign.right,

                                            style: GoogleFonts.cairo(
                                              color: Colors.grey.shade700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      padding: const EdgeInsets.all(16),

                                      decoration: BoxDecoration(
                                        color: AppColors.lightyallow,

                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.yallow,
                                          width: 2,
                                        ),
                                      ),

                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${state.price.data.totalPrice.toStringAsFixed(0)} ل.س",
                                            style: GoogleFonts.cairo(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          Text(
                                            "المجموع الكلي",
                                            style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }

                          if (state is ShipLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return const SizedBox();
                        },
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CreateShipCubit, ShipmentState>(
                builder: (context, state) {
                  if (state is ShipLoading) {
                    return ElevatedButton(
                      onPressed: null,

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),

                        backgroundColor: AppColors.mainblue,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  return SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      onPressed: () {
                        print(createShipCubit.polyline);
                        print(createShipCubit.distance);
                        print(createShipCubit.duration);
                        final request = ShipmentRequest(
                          goodsType: createShipCubit.goodsTypeController.text,

                          weight:
                              double.tryParse(
                                createShipCubit.weightController.text,
                              ) ??
                              0,

                          vehicleType: createShipCubit.truckTypeController.text,

                          vehicleCapacityKg:
                              createShipCubit.trucksizeController.text,

                          whoPays: createShipCubit.whoPays,

                          scheduledPickupAt:
                              createShipCubit.scheduleController.text,

                          additionalDetails:
                              createShipCubit.notesController.text,

                          media: [],

                          route: RouteRequest(
                            //
                            overviewPolyline: createShipCubit.polyline ?? "",
                            distance: createShipCubit.distance ?? 0,
                            durationMinutes:
                                (createShipCubit.duration ?? 0) ~/ 60,
                            pickUpLat: createShipCubit.pickuplatController.text,
                            pickUpLng: createShipCubit.pickuplngController.text,

                            deliveryLat:
                                createShipCubit.deliverylatController.text,
                            deliveryLng:
                                createShipCubit.deliverylngController.text,

                            //
                            pickUpCheckpointDetails: CheckpointRequest(
                              supervisorName:
                                  createShipCubit.pickupnameController.text,

                              supervisorPhoneNumber:
                                  createShipCubit.pickupphoneController.text,

                              address:
                                  createShipCubit.pickupaddressController.text,

                              street:
                                  createShipCubit.pickupstreetController.text,

                              buildingNumber:
                                  createShipCubit.pickupbuildingController.text,
                            ),

                            deliveryCheckpointDetails: CheckpointRequest(
                              supervisorName:
                                  createShipCubit.deliverynameController.text,

                              supervisorPhoneNumber:
                                  createShipCubit.deliveryphoneController.text,

                              address: createShipCubit
                                  .deliveryaddressController
                                  .text,

                              street:
                                  createShipCubit.deliverystreetController.text,

                              buildingNumber: createShipCubit
                                  .deliverybuildingController
                                  .text,
                            ),
                          ),
                        );

                        createShipCubit.createShip(request);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainblue,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      child: Text(
                        "تأكيد الطلب",
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
