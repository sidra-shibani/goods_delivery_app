import 'package:flutter/material.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/create_ship_cubit.dart';
import 'package:goods_delivery_app/presentation/screen/shipment/truck_type_screen.dart';
import 'package:goods_delivery_app/presentation/widget/MapScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/presentation/widget/DeliveryInfoBottomSheet.dart';
import 'package:goods_delivery_app/presentation/widget/PickupInfoBottomSheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateShipmentBottomSheet extends StatefulWidget {
  const CreateShipmentBottomSheet({super.key});

  @override
  State<CreateShipmentBottomSheet> createState() =>
      _CreateShipmentBottomSheetState();
}

class _CreateShipmentBottomSheetState extends State<CreateShipmentBottomSheet> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Builder(
        builder: (formContext) {
          final createshipCubit = formContext.read<CreateShipCubit>();

          return Form(
            key: createshipCubit.formKey1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.78,

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),

                child: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 5,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.close,
                            size: 20,
                            color: Color(0xff7A7A7A),
                          ),
                        ),

                        Expanded(
                          child: Center(
                            child: Text(
                              "حدد موعد التحميل",

                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 48),
                      ],
                    ),

                    Divider(color: Colors.grey.shade200, thickness: 1),
                    GestureDetector(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2035),
                        );

                        if (pickedDate == null) return;

                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime == null) return;

                        final dateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        createshipCubit.scheduleController.text = dateTime
                            .toIso8601String();

                        setState(() {
                          selectedDate = dateTime;
                        });
                      },

                      child: _customField(
                        icon: Icons.access_time,
                        iconColor: AppColors.mainblue,
                        text: selectedDate == null
                            ? "حدد موعد التحميل"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                  " - "
                                  "${selectedDate!.hour.toString().padLeft(2, '0')}:"
                                  "${selectedDate!.minute.toString().padLeft(2, '0')}",
                      ),
                    ),

                    const SizedBox(height: 18),
                    //تحدديد موقع التحميل على الخريطة
                    GestureDetector(
                      onTap: () async {
                        final location = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const MapPickerScreen(),
                        );

                        if (location != null) {
                          createshipCubit.pickuplatController.text = location
                              .latitude
                              .toString();

                          createshipCubit.pickuplngController.text = location
                              .longitude
                              .toString();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم حفظ موقع التحميل"),
                            ),
                          );
                        }
                      },

                      child: _customField(
                        icon: Icons.location_on,
                        iconColor: Colors.red,
                        text: "حدد عنوان التحميل على الخريطة",
                      ),
                    ),
                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const PickupInfoBottomSheet(),
                        );
                      },

                      child: _customField(
                        icon: Icons.gps_fixed,
                        iconColor: Colors.grey,
                        text: "تفاصيل عنوان التحميل",
                      ),
                    ),

                    const SizedBox(height: 25),

                    Divider(color: Colors.grey.shade200, thickness: 1),

                    const SizedBox(height: 25),

                    //تحديد موقع الاستلام على الخريطة
                    GestureDetector(
                      onTap: () async {
                        final location = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const MapPickerScreen(),
                        );

                        if (location != null) {
                          createshipCubit.deliverylatController.text = location
                              .latitude
                              .toString();

                          createshipCubit.deliverylngController.text = location
                              .longitude
                              .toString();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("تم حفظ موقع الاستلام"),
                            ),
                          );
                        }
                      },

                      child: _customField(
                        icon: Icons.location_on,
                        iconColor: const Color(0xffF4B400),
                        text: "حدد عنوان الاستلام على الخريطة",
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const DeliveryInfoBottomSheet(),
                        );
                      },

                      child: _customField(
                        icon: Icons.gps_fixed,
                        iconColor: Colors.grey,
                        text: "تفاصيل عنوان المستلم",
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {
                          print(
                            "Schedule: ${createshipCubit.scheduleController.text}",
                          );
                          print(
                            "Pickup Lat: ${createshipCubit.pickuplatController.text}",
                          );
                          print(
                            "Pickup Lng: ${createshipCubit.pickuplngController.text}",
                          );

                          print(
                            "Delivery Lat: ${createshipCubit.deliverylatController.text}",
                          );
                          print(
                            "Delivery Lng: ${createshipCubit.deliverylngController.text}",
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const TruckTypeScreen(),
                            ),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainblue,
                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),

                        child: Text(
                          "التالي",

                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _customField({
    required IconData icon,
    required String text,
    required Color iconColor,
  }) {
    return Container(
      height: 50,

      decoration: BoxDecoration(
        color: Colors.white,

        border: Border.all(color: const Color(0xffE3E3E3)),

        borderRadius: BorderRadius.circular(8),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),

        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 18),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.right,

                style: GoogleFonts.cairo(
                  fontSize: 14,
                  color: const Color(0xff666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
