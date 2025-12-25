import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/vehicle_provider.dart';
import 'package:vehicle_rental_app/views/user/bookvehicle_page.dart';

class UserSearchpage extends StatefulWidget {
  const UserSearchpage({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  State<UserSearchpage> createState() => _UserSearchpageState();
}

class _UserSearchpageState extends State<UserSearchpage> {
  @override
  void initState() {
    super.initState();
    // ✅ Trigger search when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleProvider>().searchvehicle(
            vehiclename: widget.searchQuery,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Search: "${widget.searchQuery}"',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Consumer<VehicleProvider>(
          builder: (context, vehicleProvider, child) {
            // Loading State
            if (vehicleProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              );
            }

            // Error State
            if (vehicleProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Error: ${vehicleProvider.errorMessage}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        vehicleProvider.searchvehicle(
                          vehiclename: widget.searchQuery,
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              );
            }

            final searchResults = vehicleProvider.searchResults;

            // Empty State
            if (searchResults.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No vehicles found for',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '"${widget.searchQuery}"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Go Back'),
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

            // Results Found
            return RefreshIndicator(
              onRefresh: () => vehicleProvider.searchvehicle(
                vehiclename: widget.searchQuery,
              ),
              color: Colors.deepPurple,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Results Count
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.deepPurple,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${searchResults.length} result${searchResults.length > 1 ? 's' : ''} found',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Grid View
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final vehicle = searchResults[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookvehiclePage(
                                    vehicleId: vehicle.id ?? '',
                                    vehicleBrand: vehicle.brand ?? 'Unknown',
                                    vehicleType: vehicle.type ?? '',
                                    pricePerDay: vehicle.pricePerDay ?? 0,
                                    imageUrl: vehicle.imageUrl.isNotEmpty
                                        ? vehicle.imageUrl.first
                                        : '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Vehicle Image
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: vehicle.imageUrl.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: vehicle.imageUrl.first,
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              height: 120,
                                              color: Colors.grey.shade200,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.deepPurple,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              height: 120,
                                              color: Colors.grey.shade200,
                                              child: const Icon(
                                                Icons.car_rental,
                                                size: 40,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 120,
                                            color: Colors.grey.shade200,
                                            child: const Icon(
                                              Icons.car_rental,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                  
                                  // Vehicle Details
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vehicle.brand ?? 'Unknown',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple.shade100,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            vehicle.type ?? '',
                                            style: const TextStyle(
                                              color: Colors.deepPurple,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Rs. ${vehicle.pricePerDay}/day',
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}