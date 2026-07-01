import 'dart:developer';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ReverbClient {
  ReverbClient._();
  static final ReverbClient instance = ReverbClient._();

  PusherChannelsClient? _client;
  bool _initialized = false;

  PusherChannelsClient get client {
    if (_client == null) {
      throw Exception("ReverbClient not initialized");
    }
    return _client!;
  }

  Future<void> init() async {
    if (_initialized) return;

    final host = dotenv.env['REVERB_HOST']!;
    final port = int.parse(dotenv.env['REVERB_PORT']!);
    final key = dotenv.env['REVERB_APP_KEY']!;
    final scheme = dotenv.env['REVERB_SCHEME'] ?? 'http';

    final options = PusherChannelsOptions.fromHost(
      host: host,
      port: port,
      key: key,
      scheme: scheme,
      shouldSupplyMetadataQueries: true,
      metadata: PusherChannelsOptionsMetadata.byDefault(),
    );

    _client = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (exception, trace, refresh) {
        debugPrint("Reverb error: $exception");
        refresh();
      },
    );

    _client!.onConnectionEstablished.listen((event) {
      debugPrint("✅ Connected to Reverb");
    });

    await _client!.connect();
    _initialized = true;

    log("Reverb initialized");
  }

  void disconnect() {
    _client?.dispose();
    _client = null;
    _initialized = false;
  }
}
