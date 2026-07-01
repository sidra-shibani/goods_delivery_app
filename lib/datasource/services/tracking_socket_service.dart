import 'dart:convert';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:goods_delivery_app/datasource/services/reverb_client.dart';

class TrackingSocketService {
  final ReverbClient reverb;

  TrackingSocketService(this.reverb);

  PrivateChannel? _channel;

  void subscribe({
    required int shipmentId,
    required String token,
    required Function(double lat, double lng) onUpdate,
  }) {
    _channel = reverb.client.privateChannel(
      'shipment.$shipmentId',
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
            authorizationEndpoint: Uri.parse(
              "http://10.0.2.2:8000/broadcasting/auth",
            ),
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
            },
          ),
    );
    print("📡 Subscribing to shipment.$shipmentId");
    reverb.client.onConnectionEstablished.listen((_) {
      _channel?.subscribe();
    });
    _channel!.subscribe();

    print("✅ Channel subscribed");
    _channel!.bind('location.updated').listen((event) {
      final data = jsonDecode(event.data);
      print("🔥 Event received");
      print(event.data);
      final lat = (data['lat'] as num).toDouble();
      final lng = (data['lng'] as num).toDouble();

      onUpdate(lat, lng) {
        print("📍 Driver: $lat , $lng");
      }
    });
  }

  void unsubscribe() {
    _channel?.unsubscribe();
    _channel = null;
  }
}
