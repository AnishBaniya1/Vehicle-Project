import 'package:vehicle_rental_app/core/dataprovider/api_endpoints.dart';
import 'package:vehicle_rental_app/core/dataprovider/api_service.dart';

class VehicleService {
  final ApiService _apiService = ApiService.instance;

  // Get Available vehicles to user
  Future<Map<String, dynamic>> availablevehicle() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.availableCarApi,
      isWithoutToken: false,
    );

    return response;
  }

  //Book a Vehicle
  Future<Map<String, dynamic>> bookvehicle({required String body}) async {
    final response = await _apiService.httpPost(
      body: body,
      url: ApiEndpoints.bookCarApi,
      isWithoutToken: false,
    );

    return response;
  }

  // Get User Booking History
  Future<Map<String, dynamic>> userbookinghistory() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.userBookingHistoryApi,
      isWithoutToken: false,
    );

    return response;
  }

  // Search for Vehicle
  Future<Map<String, dynamic>> searchvehicle({required String search}) async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.searchCarApi(search),
      isWithoutToken: false,
    );

    return response;
  }

  // Get all Vehicles for admin
  Future<Map<String, dynamic>> getvehicles() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.getVehicleApi,
      isWithoutToken: false,
    );

    return response;
  }

  //Delete Vehicle
  Future<Map<String, dynamic>> deletevehicle({
    required String vehicleId,
  }) async {
    final response = await _apiService.httpDelete(
      url: ApiEndpoints.deleteCarApi(vehicleId),
      isWithoutToken: false,
    );

    return response;
  }

  //Edit Vehicle
  Future<Map<String, dynamic>> editvehicle({
    required String vehicleId,
    required String body,
  }) async {
    final response = await _apiService.httpPut(
      body: body,
      url: ApiEndpoints.editCarApi(vehicleId),
      isWithoutToken: false,
    );

    return response;
  }

  //Add Vehicle with images (Multipart)
  Future<Map<String, dynamic>> addvehicle({
    required Map<String, String> fields,
    required List<String> imagePaths,
  }) async {
    final response = await _apiService.httpPostMultipart(
      url: ApiEndpoints.addCarApi,
      fields: fields,
      filePaths: imagePaths,
      fileFieldName: 'images', // Backend field name for images
      isWithoutToken: false,
    );
    return response;
  }

  // Get pending Bookings for admin
  Future<Map<String, dynamic>> getpendingbookings() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.getPendingApi,
      isWithoutToken: false,
    );

    return response;
  }

  // Get approved Bookings for admin
  Future<Map<String, dynamic>> getapprovedbookings() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.getApprovedApi,
      isWithoutToken: false,
    );

    return response;
  }

  // Approve Booking
  Future<Map<String, dynamic>> approvebooking({required int bookingId}) async {
    final response = await _apiService.httpPatch(
      url: ApiEndpoints.approveBookingApi(bookingId),
      body: '{}',
      isWithoutToken: false,
    );

    return response;
  }

  // Cancel Booking
  Future<Map<String, dynamic>> cancelbooking({required int bookingId}) async {
    final response = await _apiService.httpPut(
      url: ApiEndpoints.cancelBookingApi(bookingId),
      body: '{}',
      isWithoutToken: false,
    );

    return response;
  }
}
