import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:goods_delivery_app/bussiness/Rating_cubit/Rating_state.dart';
import 'package:goods_delivery_app/datasource/model/rating_model.dart';

import 'package:goods_delivery_app/datasource/repository/Rating_repo.dart';

class GiveratingCubit extends Cubit<RatingState> {
  final RatingRepo repository;

  TextEditingController commentController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int rating = 0;

  GiveratingCubit(this.repository) : super(RatingInitial());
  void updateRating(int value) {
    rating = value;
    emit(RatingChanged(value));
  }

  Future<void> giveRating(GiveRatingRequest ratingData, int shipmentId) async {
    emit(RatingLoading());

    try {
      final result = await repository.giveRating(ratingData, shipmentId);

      result.fold(
        (error) {
          emit(RatingError(error.message));
        },
        (response) async {
          emit(GiveRatingLoaded(response));
        },
      );
    } catch (e) {
      emit(RatingError('An unexpected error occurred.'));
    }
  }
}
