import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:goods_delivery_app/datasource/model/error.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:goods_delivery_app/datasource/webserver/shipment_server.dart';

class ShipmentRepo {
  final ShipmentServer service;

  ShipmentRepo(this.service);

  Future<Either<ApiError, ShipmentResponse>> createShipment(
    ShipmentRequest model,
    List<File> images,
  ) async {
    try {
      final response = await service.createShipment(model, images);
      return Right(ShipmentResponse.fromJson(response.data));
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

  Future<Either<ApiError, ShipmentResponse>> getship() async {
    try {
      final response = await service.getMyshipments();

      return Right(ShipmentResponse.fromJson(response.data));
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

  Future<Either<ApiError, ShipmentPriceResponse>> getprice(
    CalculatePriceRequest model,
  ) async {
    try {
      final response = await service.getShipmentPrice(model);

      return Right(ShipmentPriceResponse.fromJson(response.data));
    } on DioException catch (dioErr) {
      print("TYPE: ${dioErr.type}");
      print("MESSAGE: ${dioErr.message}");
      print("ERROR: ${dioErr.error}");
      print("RESPONSE: ${dioErr.response}");

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

  Future<Either<ApiError, DeleteShipResponse>> deleteShip(
    int shipmentId,
  ) async {
    try {
      final response = await service.deleteShipment(shipmentId);

      return Right(DeleteShipResponse.fromJson(response.data));
    } on DioException catch (dioErr) {
      print("TYPE: ${dioErr.type}");
      print("MESSAGE: ${dioErr.message}");
      print("ERROR: ${dioErr.error}");
      print("RESPONSE: ${dioErr.response}");

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
