import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:goods_delivery_app/const/strings.dart';
import 'package:goods_delivery_app/notifications/repo/notification_repo.dart';
import 'package:goods_delivery_app/notifications/services/push_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepoImpl implements NotificationRepo {
  final PushNotificationService pushNotificationService;
  late Dio dio;
  NotificationRepoImpl(this.pushNotificationService) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 66),
        responseType: ResponseType.json,
        followRedirects: true,
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

  @override
  Future<bool> fetchAndSendFcmToken() async {
    //TODO main function
    final token = await getFcmToken();
    return updateFirebaseToken(token);
  }

  @override
  Future<String> getFcmToken() async {
    try {
      final token = await pushNotificationService.getToken();
      log('🔥🔥🔥 FCM TOKEN: $token 🔥🔥🔥');
      if (token != null && token.isNotEmpty) {
        return token;
      }
      return token!;
    } catch (e) {
      return '';
    }
  }

  @override
  Future<bool> updateFirebaseToken(String token) async {
    try {
      final response = await dio.patch(
        '/account-center/fcm-token',
        data: {'fcm_token': token},
      );
      bool result = response.data['status'] == 'success' ? true : false;
      return result;
    } catch (e) {
      return false; //TODO handel exception
    }
  }

  // @override
  // Future<Either<Failure, String>> getFcmToken() async {
  //   try {
  //     final token = await pushNotificationService.getToken();
  //     log(
  //       '-------------------------------FCM Token : $token ------------------------------------',
  //     );
  //     if (token != null && token.isNotEmpty) {
  //       return right(token);
  //     } else {
  //       return left(ServerFailure('FCM Token is null or empty'));
  //     }
  //   } catch (e) {
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<Failure, bool>> updateFirebaseToken(String token) async {
  //   try {
  //     final response = await apiService.patch(
  //       endPoint: 'account-center/fcm-token',
  //       data: {'fcm_token': token},
  //     );
  //     bool result = response.data['status'] == 'success' ? true : false;
  //     return right(result);
  //   } on DioException catch (e) {
  //     return left(ServerFailure.fromDioException(e));
  //   } catch (e) {
  //     return left(ServerFailure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<Failure, bool>> fetchAndSendFcmToken() async {
  //   final tokenResult = await getFcmToken();
  //   return tokenResult.fold(
  //     (failure) => left(failure),
  //     (token) => updateFirebaseToken(token),
  //   );
  // }
}
