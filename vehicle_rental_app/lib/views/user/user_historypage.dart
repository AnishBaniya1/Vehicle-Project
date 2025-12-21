import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/vehicle_provider.dart';
import 'package:vehicle_rental_app/models/userbookinghistory_model.dart';

class UserHistorypage extends StatefulWidget {
  const UserHistorypage({super.key});

  @override
  State<UserHistorypage> createState() => _UserHistorypageState();
}

class _UserHistorypageState extends State<UserHistorypage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleProvider>().userbookinghistory();
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(
            'Booking History',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer<VehicleProvider>(
          builder: (context, vehicleProvider, child) {
            if (vehicleProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vehicleProvider.bookings.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: screenWidth * 0.2,
                      color: Colors.grey,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'No booking history',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(screenWidth * 0.04),
              itemCount: vehicleProvider.bookings.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final bookingData = vehicleProvider.bookings[index];
                final booking = bookingData.booking;
                final vehicle = bookingData.vehicle;

                return Card(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: vehicle!.images.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: vehicle.images.first,
                                      width: screenWidth * 0.25,
                                      height: screenWidth * 0.25,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        width: screenWidth * 0.25,
                                        height: screenWidth * 0.25,
                                        color: Colors.grey.shade200,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            width: screenWidth * 0.25,
                                            height: screenWidth * 0.25,
                                            color: Colors.grey.shade200,
                                            child: const Icon(Icons.car_rental),
                                          ),
                                    )
                                  : Container(
                                      width: screenWidth * 0.25,
                                      height: screenWidth * 0.25,
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.car_rental),
                                    ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vehicle.brand ?? '',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.02,
                                      vertical: screenHeight * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(
                                        booking?.status,
                                      ).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      booking?.status?.toUpperCase() ??
                                          'UNKNOWN',
                                      style: TextStyle(
                                        color: _getStatusColor(booking?.status),
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: screenHeight * 0.03),
                        // Booking Details
                        _buildDetailRow(
                          'Booking Date:',
                          '${_formatDate(booking?.startDate)} - ${_formatDate(booking?.endDate)}',
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _buildDetailRow(
                          'Booked On:',
                          _formatDate(booking?.createdAt),
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _buildDetailRow(
                          'Total Price:',
                          'Rs. ${booking?.totalPrice ?? 0}',
                          screenWidth,
                          isAmount: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    double screenWidth, {
    bool isAmount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isAmount ? screenWidth * 0.045 : screenWidth * 0.035,
            fontWeight: isAmount ? FontWeight.bold : FontWeight.w500,
            color: isAmount ? Colors.deepPurple : Colors.black,
          ),
        ),
      ],
    );
  }
}
