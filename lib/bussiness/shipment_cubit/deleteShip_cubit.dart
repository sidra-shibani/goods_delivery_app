import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

class DeleteShipCubit extends Cubit<ShipmentState> {
  final ShipmentRepo repository;

  DeleteShipCubit(this.repository) : super(ShipInitial());

  Future<void> deleteShipment(int shipmentId) async {
    emit(ShipLoading());
    final response = await repository.deleteShip(shipmentId);
    print(response);
    response.fold((error) {
      emit(ShipError(error.message));
    }, (data) => emit(DeleteShipLoaded(data)));
  }
}
