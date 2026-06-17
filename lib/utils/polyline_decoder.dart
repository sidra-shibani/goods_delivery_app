import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

List<LatLng> decodePolyline(String encoded) {
  PolylinePoints polylinePoints = PolylinePoints();

  List<PointLatLng> result = polylinePoints.decodePolyline(encoded);

  return result.map((e) => LatLng(e.latitude, e.longitude)).toList();
}
