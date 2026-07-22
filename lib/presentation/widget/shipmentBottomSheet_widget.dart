import 'package:flutter/material.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/create_ship_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/price_cubit.dart';
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
  bool pickupLocationSelected = false;
  bool deliveryLocationSelected = false;

  bool pickupDetailsSelected = false;
  bool deliveryDetailsSelected = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Builder(
        builder: (formContext) {
          final rootContext = ScaffoldMessenger.of(context).context;
          final createshipCubit = formContext.read<CreateShipCubit>();
          final pricecubit = formContext.read<PriceCubit>();
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
                            _clearFields(createshipCubit);
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
                        final utcDateTime = dateTime.toUtc();

                        createshipCubit.scheduleController.text = utcDateTime
                            .toIso8601String();

                        pricecubit.scheduleController.text = utcDateTime
                            .toIso8601String();
                        setState(() {
                          selectedDate = dateTime;
                        });
                      },

                      child: _customField(
                        icon: Icons.access_time,
                        iconColor: AppColors.mainblue,
                        //selected: selectedDate != null,
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
                          useRootNavigator: true,
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

                          setState(() {
                            pickupLocationSelected = true;
                          });
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
                        selected: pickupLocationSelected,
                        text: pickupLocationSelected
                            ? "تم اختيار موقع المرسل"
                            : "حدد عنوان التحميل على الخريطة",
                      ),
                    ),
                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const PickupInfoBottomSheet(),
                        );

                        setState(() {
                          pickupDetailsSelected = true;
                        });
                      },

                      child: _customField(
                        icon: Icons.gps_fixed,
                        iconColor: Colors.grey,
                        selected: pickupDetailsSelected,
                        text: pickupDetailsSelected
                            ? "تم إدخال بيانات المرسل"
                            : "تفاصيل عنوان التحميل",
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

                          final success = await createshipCubit.getRouteData(
                            pickLat: double.parse(
                              createshipCubit.pickuplatController.text,
                            ),
                            pickLng: double.parse(
                              createshipCubit.pickuplngController.text,
                            ),
                            delLat: location.latitude,
                            delLng: location.longitude,
                          );

                          if (!mounted) return;

                          if (success) {
                            setState(() {
                              deliveryLocationSelected = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("تم حفظ موقع الاستلام"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "فشل حساب المسار، حاول مجدداً بعد التأكد من الاتصال",
                                ),
                              ),
                            );
                          }
                        }
                      },

                      child: _customField(
                        icon: Icons.location_on,
                        iconColor: const Color(0xffF4B400),
                        selected: deliveryLocationSelected,
                        text: deliveryLocationSelected
                            ? "تم اختيار موقع المستلم"
                            : "حدد عنوان الاستلام على الخريطة",
                      ),
                    ),

                    const SizedBox(height: 12),

                    GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const DeliveryInfoBottomSheet(),
                        );

                        setState(() {
                          deliveryDetailsSelected = true;
                        });
                      },
                      child: _customField(
                        icon: Icons.gps_fixed,
                        iconColor: Colors.grey,
                        selected: deliveryDetailsSelected,
                        text: deliveryDetailsSelected
                            ? "تم إدخال بيانات المستلم"
                            : "تفاصيل عنوان المستلم",
                      ),
                    ),

                    const Spacer(),
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: () {
                          print("BUTTON PRESSED");
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

                          final cubit = context.read<CreateShipCubit>();
                          final form = cubit.formKey1.currentState;
                          if (form == null ||
                              !form.validate() ||
                              !_validateAll(cubit)) {
                            setState(() {
                              errorMessage = _getError(cubit);
                            });
                            return;
                          }

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
    bool selected = false,
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
            if (selected) const Icon(Icons.check_circle, color: Colors.green),
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

  bool _validateAll(CreateShipCubit cubit) {
    if (cubit.scheduleController.text.isEmpty) return false;
    if (cubit.pickuplatController.text.isEmpty) return false;
    if (cubit.pickuplngController.text.isEmpty) return false;
    if (cubit.deliverylatController.text.isEmpty) return false;
    if (cubit.deliverylngController.text.isEmpty) return false;
    if (!pickupDetailsSelected) return false;
    if (!deliveryDetailsSelected) return false;
    return true;
  }

  void _clearFields(CreateShipCubit cubit) {
    cubit.scheduleController.clear();
    cubit.pickuplatController.clear();
    cubit.deliverylatController.clear();
    cubit.pickuplngController.clear();
    cubit.deliverylngController.clear();
  }

  String _getError(CreateShipCubit cubit) {
    if (cubit.scheduleController.text.isEmpty) {
      return "يرجى تحديد موعد التحميل";
    }

    if (cubit.pickuplatController.text.isEmpty ||
        cubit.pickuplngController.text.isEmpty) {
      return "يرجى تحديد موقع المرسل";
    }

    if (!pickupDetailsSelected) {
      return "يرجى إدخال تفاصيل التحميل";
    }

    if (cubit.deliverylatController.text.isEmpty ||
        cubit.deliverylngController.text.isEmpty) {
      return "يرجى تحديد موقع المستلم";
    }

    if (!deliveryDetailsSelected) {
      return "يرجى إدخال تفاصيل المستلم";
    }

    return "يرجى إكمال جميع البيانات";
  }
}
