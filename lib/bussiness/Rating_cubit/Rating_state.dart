import 'package:goods_delivery_app/datasource/model/rating_model.dart';

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingError extends RatingState {
  final String message;
  RatingError(this.message);
}

class GetRatingSummeryLoaded extends RatingState {
  final RatingSummaryResponse response;

  GetRatingSummeryLoaded(this.response);
}

class GiveRatingLoaded extends RatingState {
  final GiveRatingResponse response;

  GiveRatingLoaded(this.response);
}

class RatingChanged extends RatingState {
  final int rating;

  RatingChanged(this.rating);
}
