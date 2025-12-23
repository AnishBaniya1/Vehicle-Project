import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/booking_provider.dart';
import 'package:vehicle_rental_app/views/admin/widget/bookingcard.dart';

class AdminBookingsPage extends StatefulWidget {
  const AdminBookingsPage({super.key});

  @override
  State<AdminBookingsPage> createState() => _AdminBookingsPageState();
}

class _AdminBookingsPageState extends State<AdminBookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // ✅ Changed to 2

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDataForCurrentTab();
    });

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadDataForCurrentTab();
      }
    });
  }

  void _loadDataForCurrentTab() {
    final provider = context.read<BookingProvider>();

    switch (_tabController.index) {
      case 0:
        provider.getPendingBookings(); // ✅ Pending first (needs action)
        break;
      case 1:
        provider.getApprovedBookings(); // ✅ Approved second (reference)
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Bookings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Tab Bar with Badge Counts
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Consumer<BookingProvider>(
              builder: (context, provider, child) {
                return TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.deepPurple,
                  indicatorWeight: 3,
                  labelColor: Colors.deepPurple,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    // Pending Tab with Badge
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.pending_actions, size: 22),
                          const SizedBox(width: 8),
                          const Text('Pending'),
                          if (provider.pendingBookings.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${provider.pendingBookings.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Approved Tab with Badge
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle, size: 22),
                          const SizedBox(width: 8),
                          const Text('Approved'),
                          if (provider.approvedBookings.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${provider.approvedBookings.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(
                  showActions: true,
                  isPending: true,
                ), // Pending
                _buildBookingsList(
                  showActions: false,
                  isPending: false,
                ), // Approved
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList({
    required bool showActions,
    required bool isPending,
  }) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _loadDataForCurrentTab,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final bookings = isPending
            ? provider.pendingBookings
            : provider.approvedBookings;

        if (bookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPending ? Icons.pending_actions : Icons.check_circle,
                  size: 64,
                  color: isPending ? Colors.orange[300] : Colors.green[300],
                ),
                const SizedBox(height: 16),
                Text(
                  isPending
                      ? 'No pending bookings'
                      : 'No approved bookings yet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isPending
                      ? 'New bookings will appear here'
                      : 'Approved bookings will appear here',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => _loadDataForCurrentTab(),
          color: Colors.deepPurple,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return BookingCard(
                booking: booking,
                showActions: showActions,
                isGrouped: isPending, // Pending is grouped, Approved is flat
              );
            },
          ),
        );
      },
    );
  }
}
