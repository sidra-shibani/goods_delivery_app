import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/webserver/services/directions_service.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';

import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';
import 'package:image_picker/image_picker.dart';

class CreateShipCubit extends Cubit<ShipmentState> {
  final ShipmentRepo repository;
  final formKey1 = GlobalKey<FormState>();

  final pickuplatController = TextEditingController();
  final pickuplngController = TextEditingController();
  final deliverylatController = TextEditingController();
  final deliverylngController = TextEditingController();
  final scheduleController = TextEditingController();

  final formKey2 = GlobalKey<FormState>();

  final pickupnameController = TextEditingController();
  final pickupphoneController = TextEditingController();
  final pickupaddressController = TextEditingController();
  final pickupstreetController = TextEditingController();
  final pickupbuildingController = TextEditingController();
  final pickupnotesController = TextEditingController();

  final formKey3 = GlobalKey<FormState>();

  final deliverynameController = TextEditingController();
  final deliveryphoneController = TextEditingController();
  final deliveryaddressController = TextEditingController();
  final deliverystreetController = TextEditingController();
  final deliverybuildingController = TextEditingController();
  final deliverynotesController = TextEditingController();

  final truckTypeController = TextEditingController();
  final trucksizeController = TextEditingController();

  final formKey4 = GlobalKey<FormState>();

  final goodsTypeController = TextEditingController();
  final weightController = TextEditingController();
  String whoPays = "sender";
  String? polyline;
  double? distance;
  int? duration;
  final piecesCountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  TextEditingController trucksizeNameController = TextEditingController();
  final List<File> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  CreateShipCubit(this.repository) : super(ShipInitial());

  Future<void> pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 70);
    if (picked.isEmpty) return;

    selectedImages.addAll(picked.map((x) => File(x.path)));
    emit(MediaUpdated(List.from(selectedImages)));
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    emit(MediaUpdated(List.from(selectedImages)));
  }

  Future<void> createShip(ShipmentRequest request) async {
    emit(ShipLoading());
    print("عدد الصور المختارة قبل الإرسال: ${selectedImages.length}");
    try {
      final result = await repository.createShipment(request, selectedImages);

      result.fold(
        (error) {
          emit(ShipError(error.message));
        },
        (response) async {
          emit(createShipLoaded(response));
        },
      );
    } catch (e) {
      emit(ShipError('An unexpected error occurred.'));
    }
  }

  Future<bool> getRouteData({
    required double pickLat,
    required double pickLng,
    required double delLat,
    required double delLng,
  }) async {
    try {
      final result = await DirectionsService.getRoute(
        originLat: pickLat,
        originLng: pickLng,
        destLat: delLat,
        destLng: delLng,
      );

      polyline = result["polyline"];
      distance = (result["distance"] as num).toDouble();
      duration = result["duration"];

      emit(RouteCalculatedState());
      return true;
    } catch (e) {
      polyline = null;
      distance = null;
      duration = null;
      emit(ShipError("تعذر جلب بيانات المسار، تحقق من اتصال الإنترنت"));
      return false;
    }
  }
}
