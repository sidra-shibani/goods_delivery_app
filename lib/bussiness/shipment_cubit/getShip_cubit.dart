import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

class GetShipCubit extends Cubit<ShipmentState> {
  final ShipmentRepo repository;

  GetShipCubit(this.repository) : super(ShipInitial());

  Future<void> fetchShip() async {
    emit(ShipLoading());

    final response = await repository.getship();
    print(response);
    response.fold((error) {
      emit(ShipError(error.message));
    }, (data) => emit(GetShipLoaded(data)));
  }
}
