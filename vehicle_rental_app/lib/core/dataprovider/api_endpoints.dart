class ApiEndpoints {
  static const String _devUrl = 'http://10.0.2.2:5000';
  // static const String _devUrl = 'http://192.168.1.4:5000';

  // static const String _prodUrl = '';
  static const String baseUrl = _devUrl;

  static const String loginApi = '$baseUrl/api/v1/auth/login';
  static const String registerApi = '$baseUrl/api/v1/auth/register';
  static const String verifyEmailApi = '$baseUrl/api/v1/auth/verify-email';
  static const String availableCarApi =
      '$baseUrl/api/v1/user/vehicles/available';
  static String searchCarApi(String search) =>
      '$availableCarApi?search=${Uri.encodeComponent(search)}';
  static const String bookCarApi = '$baseUrl/api/v1/user/bookVehicle';
  static const String getUserApi = '$baseUrl/api/v1/user/me';
  static const String userBookingHistoryApi =
      '$baseUrl/api/v1/user/bookings/me';
  static const String changePasswordApi = '$baseUrl/api/v1/user/updatePassword';
  static const String forgetPassordApi = '$baseUrl/api/v1/auth/forget-password';
  static const String verifyotpApi = '$baseUrl/api/v1/auth/verify-otp';
  static const String setNewPassApi = '$baseUrl/api/v1/auth/set-new-password';

  //admin
  static const String getAdminApi = '$baseUrl/api/v1/admin/me';
  static const String getAdminDashboardApi = '$baseUrl/api/v1/admin/dashboard';
  static const String getVehicleApi = '$baseUrl/api/v1/admin/vehicles';
  static String deleteCarApi(String vehicleId) =>
      '$baseUrl/api/v1/admin/car/$vehicleId';
  static String editCarApi(String vehicleId) =>
      '$baseUrl/api/v1/admin/car/$vehicleId';
  static const String addCarApi = '$baseUrl/api/v1/admin/addCar';
  static const String getPendingApi =
      '$baseUrl/api/v1/admin/pending-booked-vehicles';
  static const String getApprovedApi =
      '$baseUrl/api/v1/admin/bookings/approved';
  static String approveBookingApi(int bookingId) =>
      '$baseUrl/api/v1/admin/bookings/$bookingId/approve';
  static String cancelBookingApi(int bookingId) =>
      '$baseUrl/api/v1/admin/bookings/$bookingId/cancel';
  static const String getAllUserApi = '$baseUrl/api/v1/admin/users';
  static String deleteUserApi(String userId) =>
      '$baseUrl/api/v1/admin/user/$userId';
}
