import 'package:get_it/get_it.dart';
import 'package:goods_delivery_app/datasource/webserver/services/reverb_client.dart';
import 'package:goods_delivery_app/datasource/webserver/services/tracking_socket_service.dart';

final GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerSingleton<ReverbClient>(ReverbClient.instance);
  sl.registerSingleton<TrackingSocketService>(
    TrackingSocketService(sl<ReverbClient>()),
  );
}
