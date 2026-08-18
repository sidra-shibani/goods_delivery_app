abstract class NotificationRepo {
  Future<String> getFcmToken();
  Future<bool> updateFirebaseToken(String token);
  Future<bool> fetchAndSendFcmToken();
  Future<bool> testNotification();
}
