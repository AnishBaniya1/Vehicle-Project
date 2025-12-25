import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/core/services/auth_service.dart';
import 'package:vehicle_rental_app/core/services/secure_storage.dart';
import 'package:vehicle_rental_app/models/admindashboard_model.dart';
import 'package:vehicle_rental_app/models/adminprofile_model.dart';
import 'package:vehicle_rental_app/models/getallusers_model.dart' as all_users;
import 'package:vehicle_rental_app/models/loginresponse_model.dart';
import 'package:vehicle_rental_app/models/registerresponse_model.dart';
import 'package:vehicle_rental_app/models/userprofile_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SecureStorageService _storageService = SecureStorageService();

  bool _isLoading = false;
  String? _errorMessage;
  List<all_users.User> _allUsers = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<all_users.User> get allUsers => _allUsers;

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final body = jsonEncode({'email': email, 'password': password});

      final response = await _authService.login(body: body);

      LoginResponseModel loginModel = LoginResponseModel.fromJson(response);
      await _storageService.setValue('authtoken', loginModel.token!);
      await _storageService.setValue('role', loginModel.user!.role!);
      await _storageService.setValue('islogin', 'true');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final body = jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      });

      final response = await _authService.register(body: body);
      RegisterResponseModel registerModel = RegisterResponseModel.fromJson(
        response,
      );
      await _storageService.setValue('userId', registerModel.userId!);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> verifyemail({
    required String userId,
    required String otp,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final body = jsonEncode({'userId': userId, 'otp': otp});

      await _authService.verifyemail(body: body);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> me() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _authService.me();

      UserProfileModel userModel = UserProfileModel.fromJson(response);
      final user = userModel.data;
      await _storageService.setValue('name', user?.username ?? '');
      await _storageService.setValue('email', user?.email ?? '');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> changepassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final body = jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });

      await _authService.changepassword(body: body);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  //ADMIN SECTION
  Future<void> admin() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _authService.admin();

      AdminProfileModel adminModel = AdminProfileModel.fromJson(response);
      final admin = adminModel.data;
      await _storageService.setValue('aname', admin?.username ?? '');
      await _storageService.setValue('aemail', admin?.email ?? '');
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> admindashboard() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _authService.admindashboard();

      AdminDashboardModel dashboardModel = AdminDashboardModel.fromJson(
        response,
      );
      final data = dashboardModel.data;
      await _storageService.setValue(
        'totalUsers',
        data?.users.toString() ?? '0',
      );
      await _storageService.setValue(
        'totalVehicles',
        data?.vehicles.toString() ?? '0',
      );
      await _storageService.setValue(
        'pendingBookings',
        data?.pendingBookings.toString() ?? '0',
      );
      await _storageService.setValue(
        'confirmedBookings',
        data?.confirmedBookings.toString() ?? '0',
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> getallusers() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await _authService.getallusers();

      all_users.GetAllUsersModel usersModel =
          all_users.GetAllUsersModel.fromJson(response);
      _allUsers = usersModel.data?.users ?? [];

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteuser({required String userId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _authService.deleteuser(userId: userId);
      _allUsers.removeWhere((user) => user.id == userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
