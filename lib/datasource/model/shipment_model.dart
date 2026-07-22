import 'dart:io';

import 'package:dio/dio.dart';

class ShipmentResponse {
  final String status;
  final String message;
  final ShipmentListData data;

  ShipmentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShipmentResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: ShipmentListData.fromJson(json['data'] ?? {}),
    );
  }
}

class ShipmentData {
  final int id;
  final String goodsType;
  final String vehicleSize;
  final String vehicleType;

  final double weight;
  final bool nightShipping;
  final String whoPays;
  final double price;
  final String additionalDetails;
  final String status;

  final String pickupAt;
  final String? pickedUpAt;
  final String? deliveredAt;

  final List<String>? mediaUrls;

  final Merchant merchant;
  final Driver? driver;
  final RouteModel route;

  final String createdAt;

  ShipmentData({
    required this.id,
    required this.vehicleSize,
    required this.goodsType,
    required this.vehicleType,

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
      vehicleSize: json['vehicle_size'] ?? '',
      goodsType: json['goods_type'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',

      weight: (json['weight'] ?? 0).toDouble(),
      nightShipping: json['night_shipping'] ?? false,
      whoPays: json['who_pays'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
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
      "vehicle_size": vehicleSize,
      "goods_type": goodsType,
      "vehicle_type": vehicleType,

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
  final int uid;
  final String profilePictureUrl;

  Merchant({
    required this.id,
    required this.uid,
    required this.profilePictureUrl,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      uid: json['uid'] ?? 0,
      profilePictureUrl: json['profile_picture_url'] ?? '',
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
      "uid": uid,
      "profile_picture_url": profilePictureUrl,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "address": address,
    };
  }
}

class Driver {
  final int id;
  final int userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final int age;
  final String gender;
  final String vehicleType;
  final int vehicleCapacityKg;
  final String? description;

  Driver({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.vehicleType,
    required this.vehicleCapacityKg,
    this.description,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? 0,
      userId: json['uid'],
      fullName: json['full_name'] ?? 'غير محدد',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      age: (json['age'] ?? 0),
      gender: json['gender'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',
      vehicleCapacityKg: (json['vehicle_capacity_kg'] ?? 0),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": userId,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "age": age,
      "gender": gender,
      "vehicle_type": vehicleType,
      "vehicle_capacity_kg": vehicleCapacityKg,
      "description": description,
    };
  }
}

class RouteModel {
  final String overviewPolyline;

  final double pickUpLat;
  final double pickUpLng;

  final Checkpoint pickUpCheckpointDetails;

  final double deliveryLat;
  final double deliveryLng;

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
      pickUpLat: double.tryParse(json['pickup_lat'].toString()) ?? 0.0,
      pickUpLng: double.tryParse(json['pickup_lon'].toString()) ?? 0.0,

      deliveryLat: double.tryParse(json['delivery_lat'].toString()) ?? 0.0,
      deliveryLng: double.tryParse(json['delivery_lon'].toString()) ?? 0.0,
      pickUpCheckpointDetails: Checkpoint.fromJson(
        json['pickup_checkpoint_details'] ?? {},
      ),

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
      "pickup_lat": pickUpLat,
      "pickup_lon": pickUpLng,
      "pickup_checkpoint_details": pickUpCheckpointDetails.toJson(),
      "delivery_lat": deliveryLat,
      "delivery_lon": deliveryLng,
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
  final String vehicleCapacityKg;
  final String whoPays;
  final String scheduledPickupAt;
  final String additionalDetails;
  final List<String> media; // خليها موجودة لأغراض أخرى إذا احتجتها
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

  /// يبني FormData يرسل الحقول متداخلة بصيغة Laravel + الصور كملفات
  Future<FormData> toFormData(List<File> images) async {
    final map = <String, dynamic>{
      "goods_type": goodsType,
      "weight": weight,
      "vehicle_type": vehicleType,
      "vehicle_capacity_kg": vehicleCapacityKg,
      "who_pays": whoPays,
      "scheduled_pickup_at": scheduledPickupAt,
      "additional_details": additionalDetails,

      "route[overview_polyline]": route.overviewPolyline,
      "route[pickup_lat]": route.pickUpLat,
      "route[pickup_lon]": route.pickUpLng,
      "route[distance]": route.distance,
      "route[duration_minutes]": route.durationMinutes,

      "route[pickup_checkpoint_details][supervisor_name]":
          route.pickUpCheckpointDetails.supervisorName,
      "route[pickup_checkpoint_details][supervisor_phone_number]":
          route.pickUpCheckpointDetails.supervisorPhoneNumber,
      "route[pickup_checkpoint_details][address]":
          route.pickUpCheckpointDetails.address,
      "route[pickup_checkpoint_details][street]":
          route.pickUpCheckpointDetails.street,
      "route[pickup_checkpoint_details][building_number]":
          route.pickUpCheckpointDetails.buildingNumber,

      "route[delivery_lat]": route.deliveryLat,
      "route[delivery_lon]": route.deliveryLng,

      "route[delivery_checkpoint_details][supervisor_name]":
          route.deliveryCheckpointDetails.supervisorName,
      "route[delivery_checkpoint_details][supervisor_phone_number]":
          route.deliveryCheckpointDetails.supervisorPhoneNumber,
      "route[delivery_checkpoint_details][address]":
          route.deliveryCheckpointDetails.address,
      "route[delivery_checkpoint_details][street]":
          route.deliveryCheckpointDetails.street,
      "route[delivery_checkpoint_details][building_number]":
          route.deliveryCheckpointDetails.buildingNumber,
    };

    final formData = FormData.fromMap(map);

    for (final image in images) {
      formData.files.add(
        MapEntry(
          'media[]', // عدّل الاسم لو الباك اند يطلب اسم مختلف (مثلاً images[])
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        ),
      );
    }
    print("عدد الملفات فعلياً داخل FormData: ${formData.files.length}");
    return formData;
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
      "pickup_lat": pickUpLat,
      "pickup_lon": pickUpLng,
      "pickup_checkpoint_details": pickUpCheckpointDetails.toJson(),
      "delivery_lat": deliveryLat,
      "delivery_lon": deliveryLng,
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

class ShipmentListData {
  final List<ShipmentData> shipments;

  ShipmentListData({required this.shipments});

  factory ShipmentListData.fromJson(Map<String, dynamic> json) {
    return ShipmentListData(
      shipments:
          (json['shipments'] as List?)
              ?.map((e) => ShipmentData.fromJson(e))
              .toList() ??
          [],
    );
  }
}

//موديل لحساب السعر
class CalculatePriceRequest {
  final String scheduledPickupAt;
  final double distance;
  final double weight;
  final String vehicleType;

  CalculatePriceRequest({
    required this.scheduledPickupAt,
    required this.distance,
    required this.weight,
    required this.vehicleType,
  });

  Map<String, dynamic> toJson() => {
    "scheduled_pickup_at": scheduledPickupAt,
    "distance": distance,
    "weight": weight,
    "vehicle_type": vehicleType,
  };
}

class ShipmentPriceResponse {
  final String status;
  final String message;
  final ShipmentPriceData data;

  ShipmentPriceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ShipmentPriceResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentPriceResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: ShipmentPriceData.fromJson(json['data'] ?? {}),
    );
  }
}

class ShipmentPriceData {
  final double distanceCharge;
  final double totalPrice;
  final double startingFee;
  final double refrigeratedSurcharge;
  final double weightSurcharge;
  final double nightShippingSurcharge;

  ShipmentPriceData({
    required this.distanceCharge,
    required this.totalPrice,
    required this.startingFee,
    required this.refrigeratedSurcharge,
    required this.weightSurcharge,
    required this.nightShippingSurcharge,
  });

  factory ShipmentPriceData.fromJson(Map<String, dynamic> json) {
    return ShipmentPriceData(
      distanceCharge: (json['distance_charge'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      startingFee: (json['starting_fee'] as num?)?.toDouble() ?? 0.0,
      refrigeratedSurcharge:
          (json['refrigerated_surcharge'] as num?)?.toDouble() ?? 0.0,
      weightSurcharge: (json['weight_surcharge'] as num?)?.toDouble() ?? 0.0,
      nightShippingSurcharge:
          (json['night_shipping_surcharge'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance_charge': distanceCharge,
      'total_price': totalPrice,
      'starting_fee': startingFee,
      'refrigerated_surcharge': refrigeratedSurcharge,
      'weight_surcharge': weightSurcharge,
      'night_shipping_surcharge': nightShippingSurcharge,
    };
  }
}
