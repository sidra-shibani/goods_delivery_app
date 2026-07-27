import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:goods_delivery_app/bussiness/Auth_cubit/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit/signUp_cubit.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/model/register_model.dart';
import 'package:goods_delivery_app/presentation/screen/Auth/logIn_screen.dart';

import 'package:google_fonts/google_fonts.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  String? selectedCity;
  String? selectedArea;
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
    return BlocListener<SignUpCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadedRegister) {
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
                      "تم إنشاء الحساب",
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "الرجاء تسجيل الدخول \nشكرا لثقتكم بنا ",
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

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Builder(
              builder: (formContext) {
                final signupCubit = formContext.read<SignUpCubit>();
                return Form(
                  key: signupCubit.formkey3,
                  child: Column(
                    children: [
                      const SizedBox(height: 100),

                      Container(
                        width: double.infinity,

                        decoration: const BoxDecoration(color: Colors.white),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Text(
                              "الملف الشخصي",

                              style: GoogleFonts.cairo(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "الرجاء إكمال إدخال معلوماتك الشخصية",

                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                color: AppColors.naturalgray,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // 🔹 رقم الهوية
                            TextFormField(
                              controller: signupCubit.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textDirection: TextDirection.rtl,

                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "يرجى إدخال البريد الإلكتروني";
                                }

                                final emailRegex = RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                );

                                if (!emailRegex.hasMatch(value.trim())) {
                                  return "البريد الإلكتروني غير صالح";
                                }

                                return null;
                              },

                              decoration: InputDecoration(
                                labelText: "البريد الإلكتروني",

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                prefixIcon: const Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // 🔹 رقم السجل التجاري
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: signupCubit.commercialController,
                              textDirection: TextDirection.rtl,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى إدخال الاسم";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "رقم السجل التجاري",

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                prefixIcon: const Icon(Icons.business),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // 🔹 المحافظة
                            DropdownButtonFormField<String>(
                              value: selectedCity,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى اختيار المحافظة";
                                }
                                return null;
                              },

                              decoration: InputDecoration(
                                labelText: "المحافظة",

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                prefixIcon: const Icon(Icons.location_city),
                              ),

                              items: citiesWithAreas.keys.map((city) {
                                return DropdownMenuItem(
                                  value: city,
                                  child: Text(city),
                                );
                              }).toList(),

                              onChanged: (value) {
                                setState(() {
                                  selectedCity = value;

                                  // تصفير المنطقة عند تغيير المحافظة
                                  selectedArea = null;
                                });
                              },
                            ),
                            const SizedBox(height: 20),

                            DropdownButtonFormField<String>(
                              value: selectedArea,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "يرجى اختيار المنطقة";
                                }
                                return null;
                              },

                              decoration: InputDecoration(
                                labelText: "المنطقة",

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                prefixIcon: const Icon(Icons.map),
                              ),

                              items:
                                  (selectedCity != null
                                          ? citiesWithAreas[selectedCity]!
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
                                  selectedArea = value;
                                });
                              },
                            ),
                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                Text(
                                  "على الأقل 8 أحرف",

                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    color: AppColors.naturalgray,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 60),

                            // 🔹 زر التسجيل
                            BlocBuilder<SignUpCubit, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return ElevatedButton(
                                    onPressed: null,

                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),

                                      backgroundColor: AppColors.mainblue,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),

                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                return ElevatedButton(
                                  onPressed: () {
                                    if (signupCubit.formkey3.currentState!
                                        .validate()) {
                                      final model = RegisterRequest(
                                        fullName: signupCubit
                                            .nameController
                                            .text
                                            .trim(),
                                        email: signupCubit.emailController.text
                                            .trim(),
                                        phoneNumber:
                                            "+963${signupCubit.phoneController.text.trim()}",
                                        password: signupCubit
                                            .passwordController
                                            .text
                                            .trim(),
                                        passwordConfirmation: signupCubit
                                            .passwordConController
                                            .text
                                            .trim(),
                                        commercialRegistrationNumber:
                                            signupCubit
                                                .commercialController
                                                .text
                                                .trim(),
                                        address:
                                            "$selectedCity - $selectedArea - ${signupCubit.addressController.text.trim()}",
                                      );

                                      signupCubit.signUp(model);
                                    }
                                  },

                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),

                                    backgroundColor: AppColors.mainblue,

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),

                                  child: Text(
                                    "تسجيل",
                                    style: GoogleFonts.cairo(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
