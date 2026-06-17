import 'dart:convert';
import 'package:http/http.dart' as http;

class DirectionsService {
  static const String apiKey = "AIzaSyDzOsYYDP585Bqp5kQPgKUZ1HVMFGr5H40";

  static Future<Map<String, dynamic>> getRoute({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) async {
    final url =
        "https://maps.googleapis.com/maps/api/directions/json"
        "?origin=$originLat,$originLng"
        "&destination=$destLat,$destLng"
        "&mode=driving"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body);

    if (data["status"] != "OK") {
      throw Exception(data["status"]);
    }

    final route = data["routes"][0];
    final leg = route["legs"][0];

    return {
      "polyline": route["overview_polyline"]["points"],
      "distance": leg["distance"]["value"] / 1000.0,
      "duration": leg["duration"]["value"],
    };
  }
}
