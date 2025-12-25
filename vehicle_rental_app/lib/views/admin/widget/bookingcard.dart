import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/booking_provider.dart';
import 'package:intl/intl.dart';

class BookingCard extends StatelessWidget {
  final dynamic booking;
  final bool showActions;
  final bool isGrouped;

  const BookingCard({
    super.key,
    required this.booking,
    this.showActions = true,
    this.isGrouped = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGrouped) {
      // For All/Pending bookings (grouped by vehicle)
      // Display each booking separately WITHOUT the vehicle header
      return Column(
        children: [
          ...booking.bookings.map<Widget>((bookingElement) {
            return _buildBookingItem(
              context: context,
              status: bookingElement.booking?.status ?? '',
              vehicleName: booking.car?.name ?? '',
              vehicleBrand: booking.car?.brand ?? '',
              vehicleType: booking.car?.type ?? '',
              vehicleImages: booking.car?.images ?? [],
              userName: bookingElement.user?.username ?? '',
              startDate: bookingElement.booking?.startDate,
              endDate: bookingElement.booking?.endDate,
              bookingId: bookingElement.booking?.id ?? 0,
            );
          }).toList(),
        ],
      );
    } else {
      // For Approved bookings (flat structure)
      return _buildBookingItem(
        context: context,
        status: 'CONFIRMED',
        vehicleName: booking.vehicle?.name ?? 'Unknown Vehicle',
        vehicleBrand: booking.vehicle?.brand ?? '',
        vehicleType: booking.vehicle?.type ?? '',
        vehicleImages: booking.vehicle?.images ?? [],
        userName: booking.user?.username ?? 'Unknown User',
        startDate: booking.booking?.startDate,
        endDate: booking.booking?.endDate,
        bookingId: booking.booking?.id ?? 0,
      );
    }
  }

  Widget _buildBookingItem({
    required BuildContext context,
    required String status,
    required String vehicleName,
    required String vehicleBrand,
    required String vehicleType,
    required List<String> vehicleImages,
    required String userName,
    required DateTime? startDate,
    required DateTime? endDate,
    required int bookingId,
  }) {
    final statusUpper = status.toUpperCase();
    final isPending = statusUpper == 'PENDING';
    final isApproved = statusUpper == 'CONFIRMED' || statusUpper == 'APPROVED';
    final isCancelled = statusUpper == 'CANCELLED';

    // MediaQuery for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final cardHorizontalMargin = screenWidth * 0.04; // 4% of screen width
    final cardVerticalMargin = screenHeight * 0.01; // 1% of screen height
    final cardPadding = screenWidth * 0.04; // 4% of screen width
    final imageSize =
        screenWidth * 0.2; // 20% of screen width (min 60, max 100)
    final vehicleNameSize = screenWidth * 0.045; // 4.5% of screen width
    final detailTextSize = screenWidth * 0.035; // 3.5% of screen width
    final iconSize = screenWidth * 0.045; // 4.5% of screen width
    final badgePadding = screenWidth * 0.03; // 3% of screen width
    final badgeTextSize = screenWidth * 0.03; // 3% of screen width
    final spacing = screenHeight * 0.015; // 1.5% of screen height

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: cardHorizontalMargin.clamp(12.0, 20.0),
        vertical: cardVerticalMargin.clamp(6.0, 12.0),
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding.clamp(12.0, 20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Info
            Row(
              children: [
                // Vehicle Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  child: Image.network(
                    vehicleImages.isNotEmpty ? vehicleImages.first : '',
                    width: imageSize.clamp(60.0, 100.0),
                    height: imageSize.clamp(60.0, 100.0),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: imageSize.clamp(60.0, 100.0),
                        height: imageSize.clamp(60.0, 100.0),
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.directions_car,
                          size: imageSize.clamp(30.0, 50.0),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),

                // Vehicle Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicleName,
                        style: TextStyle(
                          fontSize: vehicleNameSize.clamp(16.0, 20.0),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        '$vehicleBrand • $vehicleType',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: detailTextSize.clamp(12.0, 15.0),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Status Badge
                _buildStatusBadge(
                  context,
                  statusUpper,
                  isPending,
                  isApproved,
                  isCancelled,
                  badgePadding,
                  badgeTextSize,
                ),
              ],
            ),

            SizedBox(height: spacing.clamp(12.0, 20.0)),
            const Divider(height: 1),
            SizedBox(height: spacing.clamp(10.0, 16.0)),

            // User Info
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: iconSize.clamp(16.0, 20.0),
                  color: Colors.grey[600],
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Text(
                    userName,
                    style: TextStyle(
                      fontSize: detailTextSize.clamp(15.0, 18.0),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.clamp(6.0, 10.0)),

            // Date Range
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: iconSize.clamp(16.0, 20.0),
                  color: Colors.grey[600],
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Text(
                    '${_formatDate(startDate)} - ${_formatDate(endDate)}',
                    style: TextStyle(
                      fontSize: detailTextSize.clamp(12.0, 15.0),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Action Buttons - ONLY show for pending bookings
            if (showActions && isPending) ...[
              SizedBox(height: spacing.clamp(12.0, 20.0)),
              const Divider(height: 1),
              SizedBox(height: spacing.clamp(10.0, 16.0)),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _handleCancel(context, bookingId),
                      icon: Icon(Icons.close, size: iconSize.clamp(16.0, 20.0)),
                      label: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: detailTextSize.clamp(12.0, 15.0),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.02,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _handleApprove(context, bookingId),
                      icon: Icon(Icons.check, size: iconSize.clamp(16.0, 20.0)),
                      label: Text(
                        'Approve',
                        style: TextStyle(
                          fontSize: detailTextSize.clamp(12.0, 15.0),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.02,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    BuildContext context,
    String status,
    bool isPending,
    bool isApproved,
    bool isCancelled,
    double badgePadding,
    double badgeTextSize,
  ) {
    Color backgroundColor;
    Color textColor;
    IconData icon;

    if (isPending) {
      backgroundColor = Colors.orange[100]!;
      textColor = Colors.orange[900]!;
      icon = Icons.pending;
    } else if (isApproved) {
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green[900]!;
      icon = Icons.check_circle;
    } else {
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red[900]!;
      icon = Icons.cancel;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: badgePadding.clamp(8.0, 14.0),
        vertical: screenWidth * 0.015,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: badgeTextSize.clamp(12.0, 16.0), color: textColor),
          SizedBox(width: screenWidth * 0.01),
          Text(
            status,
            style: TextStyle(
              color: textColor,
              fontSize: badgeTextSize.clamp(10.0, 13.0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  void _handleApprove(BuildContext context, int bookingId) {
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Approve Booking',
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        content: Text(
          'Are you sure you want to approve this booking?',
          style: TextStyle(fontSize: screenWidth * 0.04),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: screenWidth * 0.038),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await context.read<BookingProvider>().approveBooking(bookingId);
                if (context.mounted) {
                  await context.read<BookingProvider>().getPendingBookings();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Booking approved successfully',
                        style: TextStyle(fontSize: screenWidth * 0.038),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to approve booking',
                        style: TextStyle(fontSize: screenWidth * 0.038),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Approve',
              style: TextStyle(fontSize: screenWidth * 0.038),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCancel(BuildContext context, int bookingId) {
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cancel Booking',
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        content: Text(
          'Are you sure you want to cancel this booking?',
          style: TextStyle(fontSize: screenWidth * 0.04),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No', style: TextStyle(fontSize: screenWidth * 0.038)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                await context.read<BookingProvider>().cancelBooking(bookingId);
                if (context.mounted) {
                  await context.read<BookingProvider>().getPendingBookings();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Booking cancelled successfully',
                        style: TextStyle(fontSize: screenWidth * 0.038),
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to cancel booking',
                        style: TextStyle(fontSize: screenWidth * 0.038),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              'Yes, Cancel',
              style: TextStyle(fontSize: screenWidth * 0.038),
            ),
          ),
        ],
      ),
    );
  }
}
