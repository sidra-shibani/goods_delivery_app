import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/Rating_state.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/giveRating_cubit.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/rating_summery_cubit.dart';
import 'package:goods_delivery_app/bussiness/Tracking_cubit/tracking_cubit.dart';
import 'package:goods_delivery_app/bussiness/Tracking_cubit/tracking_state.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:goods_delivery_app/datasource/model/rating_model.dart';
import 'package:goods_delivery_app/datasource/webserver/services/reverb_client.dart';
import 'package:goods_delivery_app/helper/core/service_locator.dart';
import 'package:goods_delivery_app/presentation/screen/homepage_screen.dart';

import 'package:goods_delivery_app/utils/polyline_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:goods_delivery_app/datasource/model/shipment_model.dart';

class TripTrackingScreen extends StatefulWidget {
  final ShipmentData shipment;

  const TripTrackingScreen({super.key, required this.shipment});

  @override
  State<TripTrackingScreen> createState() => _TripTrackingScreenState();
}

class _TripTrackingScreenState extends State<TripTrackingScreen> {
  GoogleMapController? mapController;
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  List<LatLng> polylinePoints = [];
  BitmapDescriptor? driverIcon;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await sl<ReverbClient>().init();
      await _loadDriverIcon();
      await _loadRoute();

      if (mounted) setState(() {});
    });
    Future.microtask(() {
      final driverId = widget.shipment.driver?.userId;

      if (driverId != null) {
        context.read<GetRatingSummeryCubit>().fetchRatingSummery(driverId);
      }
    });
  }

  void _fitBounds() {
    if (mapController == null || polylinePoints.isEmpty) return;

    double minLat = polylinePoints.first.latitude;
    double maxLat = polylinePoints.first.latitude;
    double minLng = polylinePoints.first.longitude;
    double maxLng = polylinePoints.first.longitude;

    for (final point in polylinePoints) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;

      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        80,
      ),
    );
  }

  Future<void> _loadRoute() async {
    polylinePoints = decodePolyline(widget.shipment.route.overviewPolyline);
    markers = _buildStaticMarkers();

    polylines = {
      Polyline(
        polylineId: const PolylineId("route"),
        points: polylinePoints,
        color: Colors.blue,
        width: 6,
      ),
    };

    if (mounted) {
      setState(() {});
    }
  }

  Set<Marker> _buildStaticMarkers() {
    final pickup = LatLng(
      widget.shipment.route.pickUpLat,
      widget.shipment.route.pickUpLng,
    );

    final delivery = LatLng(
      widget.shipment.route.deliveryLat,
      widget.shipment.route.deliveryLng,
    );

    return {
      Marker(
        markerId: const MarkerId("pickup"),
        position: pickup,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: "موقع التحميل"),
      ),
      Marker(
        markerId: const MarkerId("delivery"),
        position: delivery,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: "موقع التسليم"),
      ),
    };
  }

  Future<void> _loadDriverIcon() async {
    print("========== START LOAD DRIVER ICON ==========");

    try {
      print("1 - before BitmapDescriptor.asset");

      final icon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(50, 50)),
        'assets/images/markerTruck1.png',
      );

      print("2 - BitmapDescriptor.asset SUCCESS");

      if (!mounted) return;

      setState(() {
        driverIcon = icon;
      });

      print("3 - DRIVER ICON SET");
    } catch (e, stackTrace) {
      print("========== DRIVER ICON ERROR ==========");
      print("ERROR: $e");
      print("STACK: $stackTrace");
      print("=======================================");
    }
  }

  @override
  Widget build(BuildContext context) {
    final shipment = widget.shipment;
    final isDelivered = shipment.status == "delivered";
    final giveRatingCubit = context.read<GiveratingCubit>();
    print("POLYLINE: ${widget.shipment.route.overviewPolyline}");

    print(decodePolyline(shipment.route.overviewPolyline));
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 550,
            width: double.maxFinite,
            child: BlocListener<TrackingCubit, TrackingState>(
              listener: (context, state) {
                if (state is TrackingConnecting) {
                  log('connecting');
                }
                if (state is TrackingLocationUpdated) {
                  final driverPosition = state.position;

                  log(
                    '${driverPosition.latitude} , ${driverPosition.longitude}',
                  );

                  if (driverIcon == null) return;

                  setState(() {
                    markers.removeWhere(
                      (marker) => marker.markerId.value == "driver",
                    );

                    markers.add(
                      Marker(
                        markerId: const MarkerId("driver"),
                        position: driverPosition,
                        icon: driverIcon!,
                        infoWindow: const InfoWindow(title: "السائق"),
                      ),
                    );
                  });
                  mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(driverPosition, 9),
                  );
                }
              },
              child: GoogleMap(
                key: const ValueKey("google_map"),
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(35.0, 38.0),
                  zoom: 6,
                ),
                markers: markers,

                polylines: polylines,

                onMapCreated: (controller) {
                  mapController = controller;

                  Future.delayed(const Duration(milliseconds: 500), () {
                    _fitBounds();
                  });
                },
              ),
            ),
          ),

          /// زر الرجوع
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

          /// Bottom Sheet
          BlocListener<GiveratingCubit, RatingState>(
            listener: (context, state) {
              if (state is GiveRatingLoaded) {
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
                            "assets/images/green_icon.png",
                            height: 100,
                          ),

                          const SizedBox(height: 15),

                          Text(
                            "تم إرسال التقييم",
                            style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "نتمنى ان تكون الرحلة نالت رضاكم ",
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
                Future.delayed(const Duration(seconds: 5), () {
                  if (!mounted) return;

                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(); // إغلاق Dialog

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MainHomeScreen()),
                    (route) => false,
                  );
                });
              }

              if (state is RatingError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
                print(state.message);
              }
            },
            child: DraggableScrollableSheet(
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
                  child: Column(
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
                        isDelivered ? "انتهت الرحلة" : "تتبع الرحلة",
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),

                              /// =========================
                              /// DRIVER CARD (always shown)
                              /// =========================
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.medgray,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        "assets/images/secondpage.png",
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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

                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),

                                        BlocBuilder<
                                          GetRatingSummeryCubit,
                                          RatingState
                                        >(
                                          builder: (context, state) {
                                            if (state
                                                is GetRatingSummeryLoaded) {
                                              final rating =
                                                  state.response.data;

                                              return Text(
                                                rating.averageRating
                                                    .toStringAsFixed(1),
                                                style: GoogleFonts.cairo(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }

                                            return const Text("0.0");
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // IF DELIVERED → RATING UI
                              if (isDelivered) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _RatingStars(),
                                    Text(
                                      "الرجاء تقييم الرحلة",
                                      style: GoogleFonts.cairo(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),
                                Form(
                                  key: giveRatingCubit.formkey,
                                  child: TextFormField(
                                    controller:
                                        giveRatingCubit.commentController,
                                    textAlign: TextAlign.center,

                                    textDirection: TextDirection.rtl,

                                    decoration: InputDecoration(
                                      labelText: "اضف ملاحظات",
                                      alignLabelWithHint: true,

                                      labelStyle: GoogleFonts.cairo(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColors.medgray,
                                          width: 1,
                                        ),
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: AppColors.medgray,
                                          width: 1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade600,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                BlocBuilder<GiveratingCubit, RatingState>(
                                  builder: (context, state) {
                                    if (state is RatingLoading) {
                                      return const CircularProgressIndicator();
                                    }
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              .05,
                                            ),
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
                                            final cubit = context
                                                .read<GiveratingCubit>();
                                            print("⭐ Rating = ${cubit.rating}");
                                            print(
                                              "💬 Comment = ${cubit.commentController.text}",
                                            );
                                            final request = GiveRatingRequest(
                                              rating: cubit.rating ?? 0,
                                              comment:
                                                  cubit.commentController.text,
                                            );

                                            cubit.giveRating(
                                              request,
                                              shipment.id,
                                            );
                                          },

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.mainblue,

                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                    );
                                  },
                                ),
                              ],

                              /// IF IN TRANSIT → TRIP INFO
                              if (!isDelivered) ...[
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingStars extends StatefulWidget {
  @override
  State<_RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<_RatingStars> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GiveratingCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              cubit.updateRating(index + 1);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Icon(
              Icons.star_rounded,
              color: index < cubit.rating ? Colors.amber : Colors.grey,
              size: 30,
            ),
          ),
        );
      }),
    );
  }
}
