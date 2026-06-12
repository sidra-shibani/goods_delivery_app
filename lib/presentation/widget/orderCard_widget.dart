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
                          horizontal: 13,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusBackgroundColor(shipment.status),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Text(
                          getStatusText(shipment.status),
                          style: GoogleFonts.cairo(
                            color: getStatusTextColor(shipment.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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

String getStatusText(String status) {
  switch (status) {
    case "created":
      return "قيد الإنشاء";

    case "pending":
      return "بانتظار الموافقة";

    case "accepted":
      return "تم القبول";

    case "assigned":
      return "تم تعيين سائق";

    case "picked_up":
      return "تم الاستلام";

    case "in_transit":
      return "قيد النقل";

    case "delivered":
      return "تم التسليم";

    case "cancelled":
      return "ملغي";
    case "expired":
      return "منتهي الصلاحية";
    case "on_way_to_pickup":
      return "في الطريق للاستلام";

    default:
      return status;
  }
}

Color getStatusBackgroundColor(String status) {
  switch (status) {
    case "created":
      return AppColors.lightblue;

    case "pending":
      return Colors.orange.shade100;

    case "accepted":
      return Colors.green.shade100;

    case "assigned":
      return Colors.purple.shade100;

    case "picked_up":
      return Colors.teal.shade100;

    case "in_transit":
      return Colors.indigo.shade100;

    case "delivered":
      return Colors.green.shade200;

    case "cancelled":
      return Colors.red.shade100;
    case "expired":
      return Colors.red.shade100;
    default:
      return Colors.grey.shade200;
  }
}

Color getStatusTextColor(String status) {
  switch (status) {
    case "created":
      return Colors.blue;

    case "pending":
      return Colors.orange;

    case "accepted":
      return Colors.green;

    case "assigned":
      return Colors.purple;

    case "picked_up":
      return Colors.teal;

    case "in_transit":
      return Colors.indigo;

    case "delivered":
      return Colors.green.shade800;

    case "cancelled":
      return Colors.red;
    case "expired":
      return Colors.red;
    default:
      return Colors.grey;
  }
}
