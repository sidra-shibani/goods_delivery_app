import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:goods_delivery_app/datasource/services/reverb_client.dart';

class TrackingSocketService {
  final ReverbClient reverb;

  TrackingSocketService(this.reverb);

  PrivateChannel? _channel;
  StreamSubscription? _eventSub;
  StreamSubscription? _reconnectSub;

  void subscribe({
    required int shipmentId,
    required String token,
    required Function(double lat, double lng) onUpdate,
  }) {
    _channel = reverb.client.privateChannel(
      'private-shipment.$shipmentId',
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
            authorizationEndpoint: Uri.parse(
              "http://10.0.2.2:8000/broadcasting/auth",
            ),
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json",
            },
            onAuthFailed: (exception, trace) {
              log("❌ Auth failed: $exception");
            },
          ),
    );

    // Bind the event listener BEFORE subscribing.
    _eventSub = _channel!.bind('location.updated').listen((event) {
      log("🔥 Event received: ${event.data}");
      final data = jsonDecode(event.data);

      final lat = double.parse(data['current_lat'].toString());
      final lng = double.parse(data['current_lon'].toString());

      onUpdate(lat, lng);
    });

    // Subscribe immediately — don't wait for onConnectionEstablished,
    // since by the time this runs the socket is (almost certainly)
    // already connected from ReverbClient.init().
    _channel!.subscribe();
    log("📡 Subscribing to private-shipment.$shipmentId");

    // Also resubscribe automatically if the socket reconnects later
    // (e.g. after a dropped connection), since Reverb needs a fresh
    // pusher:subscribe frame per connection.
    _reconnectSub = reverb.client.onConnectionEstablished.listen((_) {
      log("🔄 Reconnected, re-subscribing to channel");
      _channel?.subscribe();
    });
  }

  void unsubscribe() {
    _eventSub?.cancel();
    _reconnectSub?.cancel();
    _channel?.unsubscribe();
    _channel = null;
    _eventSub = null;
    _reconnectSub = null;
  }
}
