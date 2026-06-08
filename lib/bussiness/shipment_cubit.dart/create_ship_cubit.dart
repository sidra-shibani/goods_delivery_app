import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:goods_delivery_app/bussiness/Auth_cubit.dart/login_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/shipment_state.dart';
import 'package:goods_delivery_app/datasource/model/register_model.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:goods_delivery_app/datasource/repository/Auth_repo.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

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
  String whoPays = "المرسل";
  final piecesCountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  CreateShipCubit(this.repository) : super(ShipInitial());

  Future<void> createShip(ShipmentRequest request) async {
    emit(ShipLoading());

    try {
      final result = await repository.createShipment(request);

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
}
