class ApiError implements Exception {
  final int? statusCode;
  final String message;
  final dynamic errors;
  final String? responseBody;

  ApiError({
    this.statusCode,
    required this.message,
    this.errors,
    this.responseBody,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      statusCode: json['statusCode'] ?? 500,
      message:
          json['message'] ??
          json['error'] ??
          json['detail'] ??
          'Unknown error occurred.',
      errors: json['errors'],
      responseBody: json.toString(),
    );
  }

  @override
  String toString() {
    return 'ApiError [$statusCode]: $message'
        '${errors != null ? '\nErrors: $errors' : ''}';
  }
}
