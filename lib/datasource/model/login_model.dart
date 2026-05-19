class LoginData {
  final int id;
  final String? username;
  final String role;
  final String accessToken;
  final String tokenType;

  LoginData({
    required this.id,
    required this.username,
    required this.role,
    required this.accessToken,
    required this.tokenType,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "role": role,
      "access_token": accessToken,
      "token_type": tokenType,
    };
  }
}

class LoginResponse {
  final String status;
  final String message;
  final LoginData data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: LoginData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {"status": status, "message": message, "data": data.toJson()};
  }
}
