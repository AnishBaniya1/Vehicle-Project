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
}
