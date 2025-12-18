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
}
