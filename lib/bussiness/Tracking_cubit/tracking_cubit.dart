import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Tracking_cubit/tracking_state.dart';
import 'package:goods_delivery_app/datasource/services/tracking_socket_service.dart';
import 'package:goods_delivery_app/helper/core/SharedPreferencesHelper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingCubit extends Cubit<TrackingState> {
  final TrackingSocketService socketService;

  TrackingCubit(this.socketService) : super(TrackingInitial());

  void startTracking({required int shipmentId}) async {
    final String? token = await SharedPreferencesHelper.getToken();
    emit(TrackingConnecting());
    log(token!);
    socketService.subscribe(
      shipmentId: shipmentId,
      token: token,
      onUpdate: (lat, lng) {
        emit(TrackingLocationUpdated(LatLng(lat, lng)));
      },
    );
  }

  @override
  Future<void> close() {
    socketService.unsubscribe();
    return super.close();
  }
}
