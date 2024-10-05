class Urls {
  static const String _baseUrl = 'https://sports-app-alpha.vercel.app/api/v1';
  static const String baseUrl = 'https://sports-app-alpha.vercel.app/api/v1';
  static const String login = '$_baseUrl/auth/login';
  static const String createAccount = '$_baseUrl/users';
  static const String sendEmail = '$_baseUrl/auth/forgot-password';
  static const String termsAndPolicy = '$_baseUrl/termsPolicy';
  static const String event = '$_baseUrl/event';
  static const String addEvent = '$_baseUrl/eventUser';
  static String findPartnersByEvent(String eventId) =>
      '$_baseUrl/eventUser/$eventId';
}
