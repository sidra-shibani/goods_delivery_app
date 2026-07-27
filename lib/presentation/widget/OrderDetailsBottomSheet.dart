import 'package:flutter/material.dart';
import 'package:goods_delivery_app/const/strings.dart' show ApiConstants;
import 'package:google_fonts/google_fonts.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';

class OrderDetailsBottomSheet extends StatelessWidget {
  final ShipmentData shipment;

  const OrderDetailsBottomSheet({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .88,

      decoration: const BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),

      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 5,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          "تفاصيل الطلب",
                          style: GoogleFonts.cairo(
                            fontSize: 18,
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

          Divider(color: Colors.grey.shade200),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  // صورة الشاحنة
                  // Container(
                  //   width: double.infinity,
                  //   height: 140,

                  //   decoration: BoxDecoration(
                  //     color: AppColors.lightyallow,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),

                  //   child: Center(
                  //     child: Image.asset(
                  //       "assets/images/ordertrck.png",
                  //       height: 90,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  if (shipment.mediaUrls != null &&
                      shipment.mediaUrls!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("صور الشحنة"),
                        const SizedBox(height: 10),

                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: shipment.mediaUrls!.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final rawUrl = shipment.mediaUrls![index];

                              final imageUrl =
                                  rawUrl.startsWith('http://') ||
                                      rawUrl.startsWith('https://')
                                  ? rawUrl
                                  : "${ApiConstants.imageBaseUrl}$rawUrl";

                              print(imageUrl);
                              return GestureDetector(
                                onTap: () =>
                                    _showImageDialog(context, imageUrl),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Hero(
                                    tag: imageUrl,
                                    child: Image.network(
                                      imageUrl,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 120,
                                        height: 120,
                                        color: Colors.grey.shade300,
                                        child: const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 18),
                      ],
                    ),
                  _sectionTitle("معلومات الشحنة"),

                  _infoCard(
                    children: [
                      _infoRow("رقم الطلب", shipment.id.toString()),

                      _infoRow("الحالة", shipment.status),

                      _infoRow("نوع الحمولة", shipment.goodsType),

                      _infoRow("نوع الشاحنة", shipment.vehicleType),

                      _infoRow("سعة الشاحنة", "${shipment.vehicleSize} كغ"),

                      _infoRow("وزن الحمولة", "${shipment.weight} كغ"),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _sectionTitle("معلومات الدفع"),

                  _infoCard(
                    children: [
                      _infoRow("الدافع", shipment.whoPays),

                      _infoRow("السعر", "${shipment.price} ل.س"),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _sectionTitle("عنوان التحميل"),

                  _infoCard(
                    children: [
                      _infoRow(
                        "المسؤول",
                        shipment.route.pickUpCheckpointDetails.supervisorName,
                      ),

                      _infoRow(
                        "الهاتف",
                        shipment
                            .route
                            .pickUpCheckpointDetails
                            .supervisorPhoneNumber,
                      ),

                      _infoRow(
                        "العنوان",
                        shipment.route.pickUpCheckpointDetails.address,
                      ),

                      _infoRow(
                        "الشارع",
                        shipment.route.pickUpCheckpointDetails.street,
                      ),

                      _infoRow(
                        "البناء",
                        shipment.route.pickUpCheckpointDetails.buildingNumber,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _sectionTitle("عنوان التنزيل"),

                  _infoCard(
                    children: [
                      _infoRow(
                        "المسؤول",
                        shipment.route.deliveryCheckpointDetails.supervisorName,
                      ),

                      _infoRow(
                        "الهاتف",
                        shipment
                            .route
                            .deliveryCheckpointDetails
                            .supervisorPhoneNumber,
                      ),

                      _infoRow(
                        "العنوان",
                        shipment.route.deliveryCheckpointDetails.address,
                      ),

                      _infoRow(
                        "الشارع",
                        shipment.route.deliveryCheckpointDetails.street,
                      ),

                      _infoRow(
                        "البناء",
                        shipment.route.deliveryCheckpointDetails.buildingNumber,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _sectionTitle("معلومات الرحلة"),

                  _infoCard(
                    children: [
                      _infoRow("المسافة", "${shipment.route.distance} كم"),

                      _infoRow(
                        "المدة",
                        "${shipment.route.durationMinutes} دقيقة",
                      ),

                      _infoRow("موعد التحميل", shipment.pickupAt),
                    ],
                  ),

                  const SizedBox(height: 18),

                  _sectionTitle("ملاحظات"),

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Text(
                      shipment.additionalDetails.isEmpty
                          ? "لا يوجد ملاحظات"
                          : shipment.additionalDetails,

                      style: GoogleFonts.cairo(fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Align(
        alignment: Alignment.centerRight,

        child: Text(
          title,

          style: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.mainblue,
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(children: children),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        children: [
          Expanded(
            child: Text(
              value,

              textAlign: TextAlign.left,

              style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
            ),
          ),

          Text(title, style: GoogleFonts.cairo(color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.8,
                maxScale: 5,
                child: Hero(
                  tag: imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(imageUrl, fit: BoxFit.contain),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
