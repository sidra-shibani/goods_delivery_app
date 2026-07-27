import 'dart:io';

import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:goods_delivery_app/const/strings.dart';

import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShipmentServer {
  late Dio dio;

  ShipmentServer() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 66),
        responseType: ResponseType.json,
        followRedirects: false,
        headers: {
          "Accept": "application/json",
          // "Content-Type": "application/json",
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString('auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          } else {
            options.headers.remove('Authorization');
          }

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

  Future<Response> createShipment(
    ShipmentRequest model,
    List<File> images,
  ) async {
    final formData = await model.toFormData(images);
    return dio.post('/merchant/shipments', data: formData);
  }

  Future<Response> getMyshipments() {
    return dio.get('/merchant/shipments');
  }

  Future<Response> getShipmentPrice(CalculatePriceRequest model) {
    return dio.get(
      '/merchant/shipments/calculate-price',
      queryParameters: model.toJson(),
    );
  }

  Future<Response> deleteShipment(int shipmentId) async {
    return await dio.delete("/merchant/shipments/$shipmentId");
  }
}
