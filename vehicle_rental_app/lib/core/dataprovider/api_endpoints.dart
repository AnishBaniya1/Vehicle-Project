class ApiEndpoints {
  static const String _devUrl = 'http://10.0.2.2:5000';
  // static const String _prodUrl = '';
  static const String baseUrl = _devUrl;

  static const String loginApi = '$baseUrl/api/v1/auth/login';
  static const String registerApi = '$baseUrl/api/v1/auth/register';
  static const String verifyEmailApi = '$baseUrl/api/v1/auth/verify-email';
  static const String availableCarApi =
      '$baseUrl/api/v1/user/vehicles/available';
  static const String bookCarApi = '$baseUrl/api/v1/user/bookVehicle';
  static const String getUserApi = '$baseUrl/api/v1/user/me';
  static const String userBookingHistoryApi =
      '$baseUrl/api/v1/user/bookings/me';
}
