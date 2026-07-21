import 'dart:developer';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    log('Start initializing client');

    final options = PusherChannelsOptions.fromHost(
      host: '10.0.2.2',
      port: 8080,
      key: 'ykvdemrkcwgoemelrstb',
      scheme: 'ws',
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

    _client!.onConnectionEstablished.listen(
      onError: (e) {
        log('Reverb connection error');
      },
      onDone: () {
        log('Reverb connected');
      },
      (event) {
        debugPrint("✅ Connected to Reverb");
      },
    );

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
