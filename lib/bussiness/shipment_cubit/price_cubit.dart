import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

class PriceCubit extends Cubit<ShipmentState> {
  final ShipmentRepo repository;
  final scheduleController = TextEditingController();
  final weightController = TextEditingController();

  final truckTypeController = TextEditingController();

  PriceCubit(this.repository) : super(ShipInitial());

  Future<void> getprice(CalculatePriceRequest request) async {
    emit(ShipLoading());

    final response = await repository.getprice(request);
    print(response);
    response.fold((error) {
      emit(ShipError(error.message));
    }, (data) => emit(GetPriceLoaded(data)));
  }
}
