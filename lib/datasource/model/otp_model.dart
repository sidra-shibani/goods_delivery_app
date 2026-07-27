class SendOtpRequest {
  final String phoneNumber;

  SendOtpRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {"phone_number": phoneNumber};
  }

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) {
    return SendOtpRequest(phoneNumber: json["phone_number"]);
  }
}

class VerifyOtpRequest {
  final String phoneNumber;
  final String otp;

  VerifyOtpRequest({required this.phoneNumber, required this.otp});

  Map<String, dynamic> toJson() {
    return {"phone_number": phoneNumber, "otp": otp};
  }

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    return VerifyOtpRequest(
      phoneNumber: json["phone_number"],
      otp: json["otp"],
    );
  }
}

class ActivationResponse {
  final String status;
  final String message;
  final String? errors;

  ActivationResponse({
    required this.status,
    required this.message,
    this.errors,
  });

  factory ActivationResponse.fromJson(Map<String, dynamic> json) {
    return ActivationResponse(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "errors": errors};
  }
}
