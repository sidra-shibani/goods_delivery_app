import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:goods_delivery_app/datasource/model/error.dart';
import 'package:goods_delivery_app/datasource/model/login_model.dart';
import 'package:goods_delivery_app/datasource/model/register_model.dart';
import 'package:goods_delivery_app/datasource/webserver/Auth_server.dart';

class AuthRepository {
  final AuthService service;

  AuthRepository(this.service);

  Future<Either<ApiError, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await service.login(email, password);

      return Right(LoginResponse.fromJson(response.data));
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

  Future<Either<ApiError, RegisterResponse>> signUp(
    RegisterRequest model,
  ) async {
    try {
      final response = await service.signUp(model);

      return Right(RegisterResponse.fromJson(response.data));
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

  // Future<Either<ApiError, ActivationResponse>> otpver(
  //   String email,
  //   String otp,
  // ) async {
  //   try {
  //     final response = await service.otpVer(email, otp);

  //     return Right(ActivationResponse.fromJson(response.data));
  //   } on DioException catch (dioErr) {
  //     final message =
  //         dioErr.response?.data['message'] ??
  //         dioErr.message ??
  //         'Dio network error';

  //     return Left(
  //       ApiError(
  //         statusCode: dioErr.response?.statusCode ?? 0,
  //         message: message,
  //         responseBody: dioErr.response?.data.toString() ?? '',
  //       ),
  //     );
  //   } on SocketException {
  //     return Left(
  //       ApiError(
  //         statusCode: 0,
  //         message: 'No Internet connection',
  //         responseBody: '',
  //       ),
  //     );
  //   } catch (e) {
  //     return Left(ApiError(message: 'Unexpected error: $e'));
  //   }
  // }
}
