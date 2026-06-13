import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';

class TripTrackingScreen extends StatelessWidget {
  final ShipmentData shipment;

  const TripTrackingScreen({super.key, required this.shipment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                shipment.route.pickUpLat,
                shipment.route.pickUpLng,
              ),
              zoom: 12,
            ),

            markers: {
              Marker(
                markerId: const MarkerId("pickup"),
                position: LatLng(
                  shipment.route.pickUpLat,
                  shipment.route.pickUpLng,
                ),
                infoWindow: const InfoWindow(title: "مكان التحميل"),
              ),

              Marker(
                markerId: const MarkerId("delivery"),
                position: LatLng(
                  shipment.route.deliveryLat,
                  shipment.route.deliveryLng,
                ),
                infoWindow: const InfoWindow(title: "مكان التسليم"),
              ),
            },
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: .35,
            minChildSize: .35,
            maxChildSize: .50,
            builder: (context, controller) {
              return Container(
                padding: const EdgeInsets.all(20),

                decoration: const BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),

                child: SingleChildScrollView(
                  controller: controller,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Center(
                        child: Container(
                          width: 60,
                          height: 5,

                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "تتبع الرحلة",
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(15),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,

                              backgroundImage: AssetImage(
                                "assets/images/secondpage.png",
                              ),
                              // shipment.driver?.image != null
                              //     ? NetworkImage(
                              //         shipment.driver!.image,
                              //       )
                              //     : null,

                              // child: shipment.driver?.image == null
                              //     ? const Icon(Icons.person)
                              //     : null,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shipment.driver?.fullName ??
                                        "لم يتم تعيين سائق",

                                    style: GoogleFonts.cairo(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    shipment.driver?.phoneNumber ?? "",
                                    style: GoogleFonts.cairo(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CircleAvatar(
                              backgroundColor: AppColors.mainblue.withOpacity(
                                .1,
                              ),

                              child: IconButton(
                                onPressed: () {
                                  // launch phone call
                                },

                                icon: Icon(
                                  Icons.phone,
                                  color: AppColors.mainblue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "معلومات الرحلة",
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(15),

                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    shipment
                                        .route
                                        .pickUpCheckpointDetails
                                        .address,

                                    style: GoogleFonts.cairo(),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            Divider(color: Colors.grey.shade300),

                            const SizedBox(height: 15),

                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    shipment
                                        .route
                                        .deliveryCheckpointDetails
                                        .address,

                                    style: GoogleFonts.cairo(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
