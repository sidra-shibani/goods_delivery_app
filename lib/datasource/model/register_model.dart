class RegisterResponse {
  final String status;
  final String message;
  final RegisterData data;

  RegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: RegisterData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data.toJson()};
  }
}

class RegisterData {
  final RegisterUser user;
  final MerchantProfile? profile;
  final String token;

  RegisterData({required this.user, this.profile, required this.token});

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      user: RegisterUser.fromJson(json['user'] ?? {}),
      profile: json['profile'] != null
          ? MerchantProfile.fromJson(json['profile'])
          : null,
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "profile": profile?.toJson(),
      "token": token,
    };
  }
}

class RegisterUser {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String createdAt;
  final String updatedAt;

  RegisterUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

class MerchantProfile {
  final String commercialRegistrationNumber;
  final String address;

  MerchantProfile({
    required this.commercialRegistrationNumber,
    required this.address,
  });

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    return MerchantProfile(
      commercialRegistrationNumber:
          json['commercial_registration_number'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "commercial_registration_number": commercialRegistrationNumber,
      "address": address,
    };
  }
}

class RegisterRequest {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;

  final String commercialRegistrationNumber;
  final String address;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.passwordConfirmation,
    required this.commercialRegistrationNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "base": {
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
      "profile": {
        "commercial_registration_number": commercialRegistrationNumber,
        "address": address,
      },
      "login": true,
    };
  }
}
