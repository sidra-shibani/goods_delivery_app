import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goods_delivery_app/const/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selectedLocation;
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? _mapController;

  Future<void> _goToCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("يرجى تشغيل خدمة الموقع")));
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final currentLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      selectedLocation = currentLocation;
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation, zoom: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "اختر الموقع",
              style: GoogleFonts.cairo(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },

                initialCameraPosition: const CameraPosition(
                  target: LatLng(33.5138, 36.2765), // دمشق
                  zoom: 10,
                ),

                onTap: (LatLng position) {
                  setState(() {
                    selectedLocation = position;
                  });
                },

                markers: selectedLocation == null
                    ? {}
                    : {
                        Marker(
                          markerId: const MarkerId("selected"),
                          position: selectedLocation!,
                        ),
                      },
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: searchController,
                        googleAPIKey: "AIzaSyDzOsYYDP585Bqp5kQPgKUZ1HVMFGr5H40",

                        debounceTime: 800,
                        isLatLngRequired: true,

                        inputDecoration: InputDecoration(
                          hintText: "ابحث عن الموقع",
                          hintStyle: GoogleFonts.cairo(
                            color: Colors.grey.shade600,
                          ),

                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.mainblue,
                          ),

                          border: InputBorder.none,

                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),

                        getPlaceDetailWithLatLng: (Prediction prediction) {
                          final lat = double.parse(prediction.lat!);
                          final lng = double.parse(prediction.lng!);

                          setState(() {
                            selectedLocation = LatLng(lat, lng);
                          });

                          _mapController?.animateCamera(
                            CameraUpdate.newLatLngZoom(LatLng(lat, lng), 16),
                          );
                        },

                        itemClick: (Prediction prediction) {
                          searchController.text = prediction.description ?? "";

                          searchController
                              .selection = TextSelection.fromPosition(
                            TextPosition(offset: searchController.text.length),
                          );
                        },

                        boxDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        textStyle: GoogleFonts.cairo(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 95,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _goToCurrentLocation,

                    icon: Icon(Icons.my_location, color: AppColors.mainblue),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 16,
                left: 16,
                child: SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: selectedLocation == null
                        ? null
                        : () {
                            Navigator.pop(context, selectedLocation);
                          },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainblue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    child: Text(
                      "تأكيد الموقع",
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
