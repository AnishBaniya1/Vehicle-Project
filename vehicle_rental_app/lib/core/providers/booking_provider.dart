import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/core/services/vehicle_service.dart';
import 'package:vehicle_rental_app/models/allbookings_model.dart' as all;
import 'package:vehicle_rental_app/models/pendingbooking_model.dart' as pending;
import 'package:vehicle_rental_app/models/approvedbooking_model.dart'
    as approved;

class BookingProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();

  // Separate lists for each booking type
  List<all.Datum> _allBookings = [];
  List<pending.Datum> _pendingBookings = [];
  List<approved.Datum> _approvedBookings = [];

  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<all.Datum> get allBookings => _allBookings;
  List<pending.Datum> get pendingBookings => _pendingBookings;
  List<approved.Datum> get approvedBookings => _approvedBookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get PENDING bookings only
  Future<void> getPendingBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _vehicleService.getpendingbookings();
      pending.PendingBookingModel pendingBookingsModel =
          pending.PendingBookingModel.fromJson(response);
      _pendingBookings = pendingBookingsModel.data;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Get APPROVED bookings only
  Future<void> getApprovedBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _vehicleService.getapprovedbookings();
      approved.ApprovedBookingModel approvedBookingsModel =
          approved.ApprovedBookingModel.fromJson(response);
      _approvedBookings = approvedBookingsModel.data;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Approve a booking
  Future<void> approveBooking(int bookingId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _vehicleService.approvebooking(bookingId: bookingId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  // Cancel a booking
  Future<void> cancelBooking(int bookingId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _vehicleService.cancelbooking(bookingId: bookingId);

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
