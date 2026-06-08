import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../const/colors.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double basePrice = 200000;
    const double nightShipping = 25000;
    const double extraFees = 10000;

    final double totalPrice = basePrice + nightShipping + extraFees;

    return Scaffold(
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
                        "دمشق - المزة - أوتستراد المزة",
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
                        "حلب - الحمدانية",
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

                    Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: AppColors.lightyallow,

                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.yallow, width: 2),
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "200,000",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),

                          Column(
                            children: [
                              Text(
                                "شاحنة متوسطة ",
                                style: GoogleFonts.cairo(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                " براد",
                                style: GoogleFonts.cairo(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "تفاصيل إضافية",
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            "100ل.س",
                            textAlign: TextAlign.right,

                            style: GoogleFonts.cairo(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 30),
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

                    Divider(color: Colors.grey.shade300),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: AppColors.lightyallow,

                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.yallow, width: 2),
                      ),

                      child: Row(
                        children: [
                          Text(
                            "${totalPrice.toInt()} ل.س",
                            style: GoogleFonts.cairo(
                              fontSize: 14,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

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
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
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
                            Image.asset(
                              "assets/images/green_icon.png", // حط أي صورة نجاح عندك
                              height: 100,
                            ),

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

                            CircularProgressIndicator(
                              color: AppColors.mainblue,
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
