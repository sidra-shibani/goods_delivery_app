import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:goods_delivery_app/const/strings.dart';
import 'package:goods_delivery_app/datasource/model/otp_model.dart';
import 'package:goods_delivery_app/datasource/model/register_model.dart';

class AuthService {
  late Dio dio;

  AuthService() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 300),
        receiveTimeout: const Duration(seconds: 300),
        responseType: ResponseType.json,
        followRedirects: true,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('[REQUEST] → ${options.method} ${options.uri}');
          log('Headers: ${options.headers}');
          if (options.data != null) log('Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            '[RESPONSE] ← ${response.statusCode} ${response.requestOptions.uri}',
          );
          log('Response: ${jsonEncode(response.data)}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('[ERROR] ❌ ${e.type} ${e.message}');
          if (e.response != null) {
            log('Status Code: ${e.response?.statusCode}');
            log('Error Body: ${jsonEncode(e.response?.data)}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> login(String phonenumber, String password) {
    final body = {'phone_number': phonenumber, 'password': password};
    return dio.post('/account-center/merchant/login', data: json.encode(body));
  }

  Future<Response> signUp(RegisterRequest model) {
    return dio.post(
      '/account-center/register',
      data: json.encode(model.toJson()),
    );
  }

  Future<Response> otpSend(SendOtpRequest model) {
    return dio.post(
      '/account-center/send-otp',
      data: json.encode(model.toJson()),
    );
  }

  Future<Response> otpVer(VerifyOtpRequest model) {
    return dio.post(
      '/account-center/verify-otp',
      data: json.encode(model.toJson()),
    );
  }
}
