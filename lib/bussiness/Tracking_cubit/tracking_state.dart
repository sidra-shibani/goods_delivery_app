import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingConnecting extends TrackingState {}

class TrackingLocationUpdated extends TrackingState {
  final LatLng position;

  TrackingLocationUpdated(this.position);
}

class TrackingError extends TrackingState {
  final String message;

  TrackingError(this.message);
}
