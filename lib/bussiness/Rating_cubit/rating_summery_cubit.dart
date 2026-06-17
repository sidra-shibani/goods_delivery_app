import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/Rating_state.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/repository/Rating_repo.dart';
import 'package:goods_delivery_app/datasource/repository/Shipment_repo.dart';

class GetRatingSummeryCubit extends Cubit<RatingState> {
  final RatingRepo repository;

  GetRatingSummeryCubit(this.repository) : super(RatingInitial());

  Future<void> fetchRatingSummery(int id) async {
    emit(RatingLoading());

    final response = await repository.getRatingSum(id);
    print(response);
    response.fold((error) {
      emit(RatingError(error.message));
    }, (data) => emit(GetRatingSummeryLoaded(data)));
  }
}
