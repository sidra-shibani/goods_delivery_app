import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:goods_delivery_app/datasource/model/error.dart';
import 'package:goods_delivery_app/datasource/model/rating_model.dart';

import 'package:goods_delivery_app/datasource/webserver/rating_server.dart';

class RatingRepo {
  final RatingServer service;

  RatingRepo(this.service);

  Future<Either<ApiError, RatingSummaryResponse>> getRatingSum(
    int userId,
  ) async {
    try {
      final response = await service.getRatingSummery(userId);

      return Right(RatingSummaryResponse.fromJson(response.data));
    } on DioException catch (dioErr) {
      final message =
          dioErr.response?.data['message'] ??
          dioErr.message ??
          'Dio network error';

      return Left(
        ApiError(
          statusCode: dioErr.response?.statusCode ?? 0,
          message: message,
          responseBody: dioErr.response?.data.toString() ?? '',
        ),
      );
    } on SocketException {
      return Left(
        ApiError(
          statusCode: 0,
          message: 'No Internet connection',
          responseBody: '',
        ),
      );
    } catch (e) {
      return Left(ApiError(message: 'Unexpected error: $e'));
    }
  }

  Future<Either<ApiError, GiveRatingResponse>> giveRating(
    GiveRatingRequest model,
    int shipmentId,
  ) async {
    try {
      final response = await service.giveRating(shipmentId, model);

      return Right(GiveRatingResponse.fromJson(response.data));
    } on DioException catch (dioErr) {
      final message =
          dioErr.response?.data['message'] ??
          dioErr.message ??
          'Dio network error';

      return Left(
        ApiError(
          statusCode: dioErr.response?.statusCode ?? 0,
          message: message,
          responseBody: dioErr.response?.data.toString() ?? '',
        ),
      );
    } on SocketException {
      return Left(
        ApiError(
          statusCode: 0,
          message: 'No Internet connection',
          responseBody: '',
        ),
      );
    } catch (e) {
      return Left(ApiError(message: 'Unexpected error: $e'));
    }
  }
}
