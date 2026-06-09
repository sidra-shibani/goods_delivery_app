import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  final ShipmentData shipment;

  const OrderCard({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,

      decoration: BoxDecoration(
        color: const Color(0xffF7F4EC),

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: const Color(0xffE2B646), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          textDirection: TextDirection.rtl,

          children: [
            Container(
              width: 80,
              height: 65,

              decoration: BoxDecoration(
                color: const Color(0xffF2D27B),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Padding(
                padding: const EdgeInsets.all(8),

                child: Image.asset(
                  "assets/images/ordertrck.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 45,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: AppColors.lightorange,
                          borderRadius: BorderRadius.circular(25),
                        ),

                        child: Text(
                          shipment.status,
                          style: GoogleFonts.cairo(
                            color: AppColors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "طلب رقم ${shipment.id}",
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          Text(
                            "وقت الطلب : ${DateTime.parse(shipment.createdAt).hour.toString().padLeft(2, '0')}:${DateTime.parse(shipment.createdAt).minute.toString().padLeft(2, '0')}",
                            style: GoogleFonts.cairo(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${shipment.route.distance} كم",
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(width: 4),
                      const Icon(Icons.location_on_outlined, size: 16),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "تاريخ الطلب : ${DateTime.parse(shipment.createdAt).day}/${DateTime.parse(shipment.createdAt).month}/${DateTime.parse(shipment.createdAt).year}",
                        style: GoogleFonts.cairo(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.calendar_today_outlined, size: 15),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
