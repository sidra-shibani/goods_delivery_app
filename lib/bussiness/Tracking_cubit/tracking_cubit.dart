import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Tracking_cubit/tracking_state.dart';
import 'package:goods_delivery_app/datasource/services/tracking_socket_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingSocketService socketService;

  TrackingCubit(this.socketService) : super(TrackingInitial());

  void startTracking({required int shipmentId, required String token}) {
    emit(TrackingConnecting());

    socketService.subscribe(
      shipmentId: shipmentId,
      token: token,
      onUpdate: (lat, lng) {
        emit(TrackingLocationUpdated(LatLng(lat, lng)));
      },
    );
  }
}
