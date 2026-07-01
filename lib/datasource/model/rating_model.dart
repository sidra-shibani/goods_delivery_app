class RatingSummaryResponse {
  final String status;
  final String message;
  final RatingSummaryData data;

  RatingSummaryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RatingSummaryResponse.fromJson(Map<String, dynamic> json) {
    return RatingSummaryResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: RatingSummaryData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class RatingSummaryData {
  final int userId;
  final double averageRating;
  final int ratingsCount;

  RatingSummaryData({
    required this.userId,
    required this.averageRating,
    required this.ratingsCount,
  });

  factory RatingSummaryData.fromJson(Map<String, dynamic> json) {
    return RatingSummaryData(
      userId: (json['user_id'] ?? 0) as int,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      ratingsCount: (json['ratings_count'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'average_rating': averageRating,
      'ratings_count': ratingsCount,
    };
  }
}

class GiveRatingResponse {
  final String status;
  final String message;
  final RatingData data;

  GiveRatingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GiveRatingResponse.fromJson(Map<String, dynamic> json) {
    return GiveRatingResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: RatingData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class RatingData {
  final UserRate ratee;
  final UserRate rater;
  final int shipmentId;
  final int rating;
  final String? comment; // ✅ مهم
  final String createdAt;

  RatingData({
    required this.ratee,
    required this.rater,
    required this.shipmentId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  factory RatingData.fromJson(Map<String, dynamic> json) {
    return RatingData(
      ratee: UserRate.fromJson(json['ratee'] ?? {}),
      rater: UserRate.fromJson(json['rater'] ?? {}),
      shipmentId: (json['shipment_id'] ?? 0) as int,
      rating: (json['rating'] ?? 0) as int,
      comment: json['comment'], // ممكن null
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ratee': ratee.toJson(),
      'rater': rater.toJson(),
      'shipment_id': shipmentId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt,
    };
  }
}

class UserRate {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final MerchantProfile? merchantProfile;
  final DriverProfile? driverProfile;

  UserRate({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.merchantProfile,
    this.driverProfile,
  });

  factory UserRate.fromJson(Map<String, dynamic> json) {
    return UserRate(
      id: (json['id'] ?? 0) as int,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      merchantProfile: json['merchant_profile'] != null
          ? MerchantProfile.fromJson(json['merchant_profile'])
          : null,
      driverProfile: json['driver_profile'] != null
          ? DriverProfile.fromJson(json['driver_profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'merchant_profile': merchantProfile?.toJson(),
      'driver_profile': driverProfile?.toJson(),
    };
  }
}

class MerchantProfile {
  final int id;
  final String? email;
  final String? phoneNumber;
  final String address;

  MerchantProfile({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: json['id'] ?? 0,
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
    };
  }
}

class DriverProfile {
  final int id;
  final int age;
  final String gender;
  final String vehicleType;
  final String vehicleSize;
  final double vehicleCapacityKg;
  final String? description;

  DriverProfile({
    required this.id,
    required this.age,
    required this.gender,
    required this.vehicleType,
    required this.vehicleSize,
    required this.vehicleCapacityKg,
    this.description,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    return DriverProfile(
      id: json['id'] ?? 0,
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      vehicleType: json['vehicle_type'] ?? '',
      vehicleSize: json['vehicle_size'] ?? '',
      vehicleCapacityKg: json['vehicle_capacity_kg'] ?? 0,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'age': age,
      'gender': gender,
      'vehicle_type': vehicleType,
      'vehicle_size': vehicleSize,
      'vehicle_capacity_kg': vehicleCapacityKg,
      'description': description,
    };
  }
}

class GiveRatingRequest {
  final int rating;
  final String comment;

  GiveRatingRequest({required this.rating, required this.comment});

  Map<String, dynamic> toJson() {
    return {"rating": rating, "comment": comment};
  }
}
