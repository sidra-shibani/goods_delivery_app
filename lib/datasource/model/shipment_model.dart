class ShipmentResponse {
  final String status;
  final String message;
  final ShipmentData data;

  ShipmentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShipmentResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: ShipmentData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data.toJson()};
  }
}

class ShipmentData {
  final int id;
  final String goodsType;
  final String vehicleType;
  final int capacityKg;
  final double weight;
  final bool nightShipping;
  final String whoPays;
  final int price;
  final String additionalDetails;
  final String status;

  final String pickupAt;
  final String? pickedUpAt;
  final String? deliveredAt;

  final List<String> mediaUrls;

  final Merchant merchant;
  final Driver? driver;
  final RouteModel route;

  final String createdAt;

  ShipmentData({
    required this.id,
    required this.goodsType,
    required this.vehicleType,
    required this.capacityKg,
    required this.weight,
    required this.nightShipping,
    required this.whoPays,
    required this.price,
    required this.additionalDetails,
    required this.status,
    required this.pickupAt,
    this.pickedUpAt,
    this.deliveredAt,
    required this.mediaUrls,
    required this.merchant,
    this.driver,
    required this.route,
    required this.createdAt,
  });

  factory ShipmentData.fromJson(Map<String, dynamic> json) {
    return ShipmentData(
      id: json['id'] ?? 0,
      goodsType: json['goods_type'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',
      capacityKg: json['capacity_kg'] ?? 0,
      weight: (json['weight'] ?? 0).toDouble(),
      nightShipping: json['night_shipping'] ?? false,
      whoPays: json['who_pays'] ?? '',
      price: json['price'] ?? 0,
      additionalDetails: json['additional_details'] ?? '',
      status: json['status'] ?? '',
      pickupAt: json['pickup_at'] ?? '',
      pickedUpAt: json['picked_up_at'],
      deliveredAt: json['delivered_at'],
      mediaUrls: List<String>.from(json['media_urls'] ?? []),
      merchant: Merchant.fromJson(json['merchant'] ?? {}),
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      route: RouteModel.fromJson(json['route'] ?? {}),
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "goods_type": goodsType,
      "vehicle_type": vehicleType,
      "capacity_kg": capacityKg,
      "weight": weight,
      "night_shipping": nightShipping,
      "who_pays": whoPays,
      "price": price,
      "additional_details": additionalDetails,
      "status": status,
      "pickup_at": pickupAt,
      "picked_up_at": pickedUpAt,
      "delivered_at": deliveredAt,
      "media_urls": mediaUrls,
      "merchant": merchant.toJson(),
      "driver": driver?.toJson(),
      "route": route.toJson(),
      "created_at": createdAt,
    };
  }
}

class Merchant {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;

  Merchant({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "address": address,
    };
  }
}

class Driver {
  final int id;

  Driver({required this.id});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(id: json['id'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {"id": id};
  }
}

class RouteModel {
  final String overviewPolyline;

  final String pickUpLat;
  final String pickUpLng;

  final Checkpoint pickUpCheckpointDetails;

  final String deliveryLat;
  final String deliveryLng;

  final Checkpoint deliveryCheckpointDetails;

  final double distance;
  final int durationMinutes;

  RouteModel({
    required this.overviewPolyline,
    required this.pickUpLat,
    required this.pickUpLng,
    required this.pickUpCheckpointDetails,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.deliveryCheckpointDetails,
    required this.distance,
    required this.durationMinutes,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      overviewPolyline: json['overview_polyline'] ?? '',
      pickUpLat: json['pick_up_lat'] ?? '',
      pickUpLng: json['pick_up_lng'] ?? '',
      pickUpCheckpointDetails: Checkpoint.fromJson(
        json['pick_up_checkpoint_details'] ?? {},
      ),
      deliveryLat: json['delivery_lat'] ?? '',
      deliveryLng: json['delivery_lng'] ?? '',
      deliveryCheckpointDetails: Checkpoint.fromJson(
        json['delivery_checkpoint_details'] ?? {},
      ),
      distance: (json['distance'] ?? 0).toDouble(),
      durationMinutes: json['duration_minutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "overview_polyline": overviewPolyline,
      "pick_up_lat": pickUpLat,
      "pick_up_lng": pickUpLng,
      "pick_up_checkpoint_details": pickUpCheckpointDetails.toJson(),
      "delivery_lat": deliveryLat,
      "delivery_lng": deliveryLng,
      "delivery_checkpoint_details": deliveryCheckpointDetails.toJson(),
      "distance": distance,
      "duration_minutes": durationMinutes,
    };
  }
}

class Checkpoint {
  final int id;
  final String supervisorName;
  final String supervisorPhoneNumber;
  final String address;
  final String street;
  final String buildingNumber;
  final String? notes;

  Checkpoint({
    required this.id,
    required this.supervisorName,
    required this.supervisorPhoneNumber,
    required this.address,
    required this.street,
    required this.buildingNumber,
    this.notes,
  });

  factory Checkpoint.fromJson(Map<String, dynamic> json) {
    return Checkpoint(
      id: json['id'] ?? 0,
      supervisorName: json['supervisor_name'] ?? '',
      supervisorPhoneNumber: json['supervisor_phone_number'] ?? '',
      address: json['address'] ?? '',
      street: json['street'] ?? '',
      buildingNumber: json['building_number'] ?? '',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "supervisor_name": supervisorName,
      "supervisor_phone_number": supervisorPhoneNumber,
      "address": address,
      "street": street,
      "building_number": buildingNumber,
      "notes": notes,
    };
  }
}

class ShipmentRequest {
  final String goodsType;
  final double weight;
  final String vehicleType;
  final int vehicleCapacityKg;
  final String whoPays;
  final String scheduledPickupAt;
  final String additionalDetails;

  final List<String> media;

  final RouteRequest route;

  ShipmentRequest({
    required this.goodsType,
    required this.weight,
    required this.vehicleType,
    required this.vehicleCapacityKg,
    required this.whoPays,
    required this.scheduledPickupAt,
    required this.additionalDetails,
    required this.media,
    required this.route,
  });

  Map<String, dynamic> toJson() {
    return {
      "goods_type": goodsType,
      "weight": weight,
      "vehicle_type": vehicleType,
      "vehicle_capacity_kg": vehicleCapacityKg,
      "who_pays": whoPays,
      "scheduled_pickup_at": scheduledPickupAt,
      "additional_details": additionalDetails,

      "media": media,

      "route": route.toJson(),
    };
  }
}

class RouteRequest {
  final String overviewPolyline;

  final String pickUpLat;
  final String pickUpLng;

  final CheckpointRequest pickUpCheckpointDetails;

  final String deliveryLat;
  final String deliveryLng;

  final CheckpointRequest deliveryCheckpointDetails;

  final double distance;
  final int durationMinutes;

  RouteRequest({
    required this.overviewPolyline,
    required this.pickUpLat,
    required this.pickUpLng,
    required this.pickUpCheckpointDetails,
    required this.deliveryLat,
    required this.deliveryLng,
    required this.deliveryCheckpointDetails,
    required this.distance,
    required this.durationMinutes,
  });

  Map<String, dynamic> toJson() {
    return {
      "overview_polyline": overviewPolyline,
      "pick_up_lat": pickUpLat,
      "pick_up_lng": pickUpLng,
      "pick_up_checkpoint_details": pickUpCheckpointDetails.toJson(),
      "delivery_lat": deliveryLat,
      "delivery_lng": deliveryLng,
      "delivery_checkpoint_details": deliveryCheckpointDetails.toJson(),
      "distance": distance,
      "duration_minutes": durationMinutes,
    };
  }
}

class CheckpointRequest {
  final String supervisorName;
  final String supervisorPhoneNumber;
  final String address;
  final String street;
  final String buildingNumber;

  CheckpointRequest({
    required this.supervisorName,
    required this.supervisorPhoneNumber,
    required this.address,
    required this.street,
    required this.buildingNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "supervisor_name": supervisorName,
      "supervisor_phone_number": supervisorPhoneNumber,
      "address": address,
      "street": street,
      "building_number": buildingNumber,
    };
  }
}
