import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/create_ship_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goods_delivery_app/const/colors.dart';

class DeliveryInfoBottomSheet extends StatefulWidget {
  const DeliveryInfoBottomSheet({super.key});

  @override
  State<DeliveryInfoBottomSheet> createState() =>
      _DeliveryInfoBottomSheetState();
}

class _DeliveryInfoBottomSheetState extends State<DeliveryInfoBottomSheet> {
  String? selectedCitydel;
  String? selectedAreadel;
  final Map<String, List<String>> citiesWithAreas = {
    "دمشق": [
      "المزة",
      "كفرسوسة",
      "ركن الدين",
      "المالكي",
      "الميدان",
      "برزة",
      "باب توما",
      "باب شرقي",
      "القصاع",
      "الشيخ محيي الدين",
      "الصالحية",
      "أبو رمانة",
      "العدوي",
      "التجارة",
      "الزاهرة",
      "دف الشوك",
      "مشروع دمر",
      "دمر",
      "القابون",
      "جوبر",
    ],

    "ريف دمشق": [
      "جرمانا",
      "صحنايا",
      "أشرفية صحنايا",
      "داريا",
      "المعضمية",
      "قدسيا",
      "الهامة",
      "التل",
      "قطنا",
      "الكسوة",
      "دوما",
      "حرستا",
      "عربين",
      "سقبا",
      "حمورية",
      "كفربطنا",
      "زملكا",
      "يبرود",
      "النبك",
      "الزبداني",
      "بلودان",
      "سرغايا",
    ],

    "حلب": [
      "الجميلية",
      "الفرقان",
      "صلاح الدين",
      "السكري",
      "الأعظمية",
      "الحمدانية",
      "سيف الدولة",
      "الأنصاري",
      "المشهد",
      "الأشرفية",
      "الشيخ مقصود",
      "الراموسة",
      "بستان القصر",
      "العزيزية",
      "الخالدية",
      "الشعار",
      "الهلك",
      "الشيخ نجار",
    ],

    "حمص": [
      "الوعر",
      "الزهراء",
      "عكرمة",
      "الخالدية",
      "كرم الزيتون",
      "بابا عمرو",
      "الإنشاءات",
      "القصور",
      "الغوطة",
      "تلكلخ",
      "الرستن",
      "القصير",
      "تدمر",
      "المخرم",
    ],

    "حماة": [
      "الحميدية",
      "القصور",
      "البارودية",
      "جنوب الملعب",
      "غرب المشتل",
      "السلمية",
      "محردة",
      "مصياف",
      "صوران",
      "طيبة الإمام",
    ],

    "اللاذقية": [
      "الصليبة",
      "الرمل الجنوبي",
      "الرمل الشمالي",
      "مشروع الزراعة",
      "الأوقاف",
      "السكنتوري",
      "الشيخ ضاهر",
      "جبلة",
      "القرداحة",
      "الحفة",
      "كسب",
    ],

    "طرطوس": [
      "الكرامة",
      "الإنشاءات",
      "الرادار",
      "الشيخ سعد",
      "صافيتا",
      "الدريكيش",
      "بانياس",
      "القدموس",
      "مشتى الحلو",
    ],

    "إدلب": [
      "إدلب",
      "معرة النعمان",
      "سراقب",
      "جسر الشغور",
      "أريحا",
      "بنش",
      "سرمين",
      "الدانا",
      "حارم",
    ],

    "درعا": [
      "درعا البلد",
      "المحطة",
      "طريق السد",
      "إزرع",
      "الصنمين",
      "نوى",
      "طفس",
      "داعل",
      "جاسم",
      "بصرى الشام",
    ],

    "السويداء": [
      "المزرعة",
      "شهبا",
      "صلخد",
      "القريا",
      "عتيل",
      "سهوة البلاطة",
      "عرى",
      "الكفر",
    ],

    "القنيطرة": ["خان أرنبة", "البعث", "جباتا الخشب", "حضر", "الرفيد", "جباتا"],

    "دير الزور": [
      "دير الزور",
      "الميادين",
      "البوكمال",
      "العشارة",
      "القورية",
      "موحسن",
      "الكسرة",
      "التبني",
    ],

    "الرقة": ["الرقة", "الطبقة", "المنصورة", "الكرامة", "عين عيسى", "تل أبيض"],

    "الحسكة": [
      "الحسكة",
      "القامشلي",
      "المالكية",
      "رأس العين",
      "عامودا",
      "الدرباسية",
      "تل تمر",
      "الشدادي",
      "الهول",
    ],
  };

  final List<String> cities = [
    "دمشق",
    "ريف دمشق",
    "حلب",
    "حمص",
    "حماة",
    "اللاذقية",
    "طرطوس",
    "إدلب",
    "درعا",
    "السويداء",
    "القنيطرة",
    "دير الزور",
    "الرقة",
    "الحسكة",
  ];
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
                              _clearFields(createshipCubit);
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
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يرجى إدخال الاسم الكامل";
                              }
                              if (value.trim().length < 3) {
                                return "الاسم قصير جداً";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),

                          _buildField(
                            controller: createshipCubit.deliveryphoneController,
                            hint: "رقم الهاتف",
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يرجى إدخال رقم الهاتف";
                              }
                              if (value.trim().length < 9) {
                                return "رقم الهاتف غير صالح";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: selectedCitydel,
                            onChanged: (value) {
                              setState(() {
                                selectedCitydel = value;
                                selectedAreadel = null;
                              });

                              createshipCubit.deliveryaddressController.text =
                                  "${selectedCitydel ?? ''}";
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى اختيار المحافظة";
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              hintText: "المحافظة",
                              hintStyle: GoogleFonts.cairo(
                                color: Colors.grey.shade600,
                              ),

                              prefixIcon: Icon(
                                Icons.location_city,
                                color: AppColors.mainblue,
                              ),

                              filled: true,
                              fillColor: Colors.grey.shade50,

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 15,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            dropdownColor: Colors.white,

                            items: citiesWithAreas.keys.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(city),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),

                          DropdownButtonFormField<String>(
                            value: selectedAreadel,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "يرجى اختيار المنطقة";
                              }
                              return null;
                            },

                            decoration: InputDecoration(
                              hintText: "المنطقة",
                              hintStyle: GoogleFonts.cairo(
                                color: Colors.grey.shade600,
                              ),

                              prefixIcon: Icon(
                                Icons.map,
                                color: AppColors.mainblue,
                              ),

                              filled: true,
                              fillColor: Colors.grey.shade50,

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 15,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            dropdownColor: Colors.white,

                            items:
                                (selectedCitydel != null
                                        ? citiesWithAreas[selectedCitydel]!
                                        : <String>[])
                                    .map((area) {
                                      return DropdownMenuItem(
                                        value: area,
                                        child: Text(area),
                                      );
                                    })
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedAreadel = value;
                              });

                              createshipCubit.deliveryaddressController.text =
                                  "${selectedCitydel ?? ''} - ${selectedAreadel ?? ''}";
                            },
                          ),
                          const SizedBox(height: 12),

                          _buildField(
                            controller:
                                createshipCubit.deliverystreetController,
                            hint: "رقم الشارع",
                            icon: Icons.route_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يرجى إدخال رقم الشارع";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          _buildField(
                            controller:
                                createshipCubit.deliverybuildingController,
                            hint: "رقم البناء",
                            icon: Icons.apartment_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "يرجى إدخال رقم البناء";
                              }
                              return null;
                            },
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

                        final form = createshipCubit.formKey3.currentState;

                        if (form != null && form.validate()) {
                          Navigator.pop(context);
                        }
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
    TextInputType keyboardType = TextInputType.text,

    String? Function(String?)? validator,

    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: TextInputAction.next,

      style: GoogleFonts.cairo(),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.cairo(color: Colors.grey.shade600),

        prefixIcon: Icon(icon, color: AppColors.mainblue),

        filled: true,
        fillColor: Colors.grey.shade50,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 15,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void _clearFields(CreateShipCubit cubit) {
    cubit.deliverynameController.clear();
    cubit.deliveryphoneController.clear();
    cubit.deliveryaddressController.clear();
    cubit.deliverystreetController.clear();
    cubit.deliverybuildingController.clear();
    cubit.deliverynotesController.clear();
  }
}
