class MeResponse {
  final MeData data;

  MeResponse({required this.data});

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(data: MeData.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() {
    return {"data": data.toJson()};
  }
}

class MeData {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;
  final MerchantProfile? merchantProfile;

  MeData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
    this.merchantProfile,
  });

  factory MeData.fromJson(Map<String, dynamic> json) {
    return MeData(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      profilePictureUrl: json['profile_picture_url'] ?? '',
      merchantProfile: json['merchant_profile'] != null
          ? MerchantProfile.fromJson(json['merchant_profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "profile_picture_url": profilePictureUrl,
      "merchant_profile": merchantProfile?.toJson(),
    };
  }
}

class MerchantProfile {
  final int id;
  final int uid;
  final String fullName;
  final String? email;
  final String? phoneNumber;
  final String profilePictureUrl;
  final String commercialRegistrationNumber;
  final String idCardNumber;
  final RatingInfo ratingInfo;
  final String address;

  MerchantProfile({
    required this.id,
    required this.uid,
    required this.fullName,
    this.email,
    this.phoneNumber,
    required this.profilePictureUrl,
    required this.commercialRegistrationNumber,
    required this.idCardNumber,
    required this.ratingInfo,
    required this.address,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'],
      phoneNumber: json['phone_number'],
      profilePictureUrl: json['profile_picture_url'] ?? '',
      commercialRegistrationNumber:
          json['commercial_registration_number'] ?? '',
      idCardNumber: json['id_card_number'] ?? '',
      ratingInfo: RatingInfo.fromJson(json['rating_info'] ?? {}),
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "profile_picture_url": profilePictureUrl,
      "commercial_registration_number": commercialRegistrationNumber,
      "id_card_number": idCardNumber,
      "rating_info": ratingInfo.toJson(),
      "address": address,
    };
  }
}

class RatingInfo {
  final double? averageRating;
  final int totalRatings;

  RatingInfo({this.averageRating, required this.totalRatings});

  factory RatingInfo.fromJson(Map<String, dynamic> json) {
    return RatingInfo(
      averageRating: json['average_rating'] != null
          ? double.tryParse(json['average_rating'].toString())
          : null,
      totalRatings: json['total_ratings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {"average_rating": averageRating, "total_ratings": totalRatings};
  }
}
