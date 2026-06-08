import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/create_ship_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goods_delivery_app/const/colors.dart';

class DeliveryInfoBottomSheet extends StatefulWidget {
  const DeliveryInfoBottomSheet({super.key});

  @override
  State<DeliveryInfoBottomSheet> createState() =>
      _DeliveryInfoBottomSheetState();
}

class _DeliveryInfoBottomSheetState extends State<DeliveryInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Builder(
        builder: (formContext) {
          final createshipCubit = formContext.read<CreateShipCubit>();
          return Container(
            height: MediaQuery.of(context).size.height * .75,

            decoration: const BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),

            child: Column(
              children: [
                // HEADER ثابت
                Padding(
                  padding: const EdgeInsets.all(20),

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

                            icon: const Icon(Icons.close),
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                "معلومات عنوان التنزيل",
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 48),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                // المحتوى المتحرك فقط
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),

                    child: Form(
                      key: createshipCubit.formKey3,

                      child: Column(
                        children: [
                          _buildField(
                            controller: createshipCubit.deliverynameController,
                            hint: "الاسم",
                            icon: Icons.person_outline,
                          ),

                          const SizedBox(height: 12),

                          _buildField(
                            controller: createshipCubit.deliveryphoneController,
                            hint: "رقم الهاتف",
                            icon: Icons.phone_outlined,
                          ),

                          const SizedBox(height: 12),

                          _buildField(
                            controller:
                                createshipCubit.deliveryaddressController,
                            hint: "العنوان",
                            icon: Icons.location_on_outlined,
                          ),

                          const SizedBox(height: 12),

                          _buildField(
                            controller:
                                createshipCubit.deliverystreetController,
                            hint: "رقم الشارع",
                            icon: Icons.route_outlined,
                          ),

                          const SizedBox(height: 12),

                          _buildField(
                            controller:
                                createshipCubit.deliverybuildingController,
                            hint: "رقم البناء",
                            icon: Icons.apartment_outlined,
                          ),

                          const SizedBox(height: 12),

                          _buildField(
                            controller: createshipCubit.deliverynotesController,
                            hint: "تفاصيل أخرى",
                            icon: Icons.notes_outlined,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // زر ثابت بالأسفل
                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),

                  child: SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        print(
                          " ${createshipCubit.deliverynameController.text}",
                        );
                        print(
                          " ${createshipCubit.deliveryaddressController.text}",
                        );
                        print(
                          " ${createshipCubit.deliveryphoneController.text}",
                        );
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainblue,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      child: Text(
                        "تم",
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,

      style: GoogleFonts.cairo(),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: GoogleFonts.cairo(color: Colors.grey.shade600),

        prefixIcon: Icon(icon, color: AppColors.mainblue),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 15,
        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
