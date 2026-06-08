import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? selectedLocation;

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
          appBar: AppBar(title: const Text("اختر الموقع")),

          body: Stack(
            children: [
              GoogleMap(
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

              Positioned(
                bottom: 20,
                right: 20,
                left: 20,
                child: ElevatedButton(
                  onPressed: selectedLocation == null
                      ? null
                      : () {
                          Navigator.pop(context, selectedLocation);
                        },

                  child: const Text("تأكيد الموقع"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
