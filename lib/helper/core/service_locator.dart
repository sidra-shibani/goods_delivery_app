import 'package:get_it/get_it.dart';
import 'package:goods_delivery_app/datasource/webserver/services/reverb_client.dart';
import 'package:goods_delivery_app/datasource/webserver/services/tracking_socket_service.dart';
import 'package:goods_delivery_app/notifications/repo/notification_repo.dart';
import 'package:goods_delivery_app/notifications/repo/notification_repo_impl.dart';
import 'package:goods_delivery_app/notifications/services/firebase_push_notification_service_impl.dart';
import 'package:goods_delivery_app/notifications/services/flutter_local_notification_service_impl.dart';
import 'package:goods_delivery_app/notifications/services/push_notification_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerSingleton<ReverbClient>(ReverbClient.instance);
  sl.registerSingleton<TrackingSocketService>(
    TrackingSocketService(sl<ReverbClient>()),
  );
  sl.registerSingleton<PushNotificationService>(
    FirebasePushNotificationServiceImpl(
      localNotificationService: FlutterLocalNotificationServiceImpl(),
    ),
  );
  sl.registerSingleton<NotificationRepo>(
    NotificationRepoImpl(sl.get<PushNotificationService>()),
  );
}
