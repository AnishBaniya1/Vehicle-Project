import 'package:vehicle_rental_app/core/dataprovider/api_endpoints.dart';
import 'package:vehicle_rental_app/core/dataprovider/api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService.instance;

  //login api call
  Future<Map<String, dynamic>> login({required String body}) async {
    final response = await _apiService.httpPost(
      url: ApiEndpoints.loginApi,
      body: body,
      isWithoutToken: true,
    );
    return response;
  }

  // Register API call
  Future<Map<String, dynamic>> register({required String body}) async {
    final response = await _apiService.httpPost(
      url: ApiEndpoints.registerApi,
      body: body,
      isWithoutToken: true,
    );

    return response;
  }

  // Verify Email API call
  Future<Map<String, dynamic>> verifyemail({required String body}) async {
    final response = await _apiService.httpPost(
      url: ApiEndpoints.verifyEmailApi,
      body: body,
      isWithoutToken: true,
    );

    return response;
  }

  // Get Current User
  Future<Map<String, dynamic>> me() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.getUserApi,
      isWithoutToken: false,
    );

    return response;
  }

  // Update Password Api
  Future<Map<String, dynamic>> changepassword({required String body}) async {
    final response = await _apiService.httpPatch(
      url: ApiEndpoints.changePasswordApi,
      body: body,
      isWithoutToken: false,
    );

    return response;
  }

  //Get Admin Profile
  Future<Map<String, dynamic>> admin() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.getAdminApi,
      isWithoutToken: false,
    );

    return response;
  }

  Future<Map<String, dynamic>> admindashboard() async {
    final response = await _apiService.httpGet(
      url: ApiEndpoints.getAdminDashboardApi,
      isWithoutToken: false,
    );

    return response;
  }
}
