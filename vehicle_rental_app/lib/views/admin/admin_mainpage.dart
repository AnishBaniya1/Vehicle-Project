import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/views/admin/admin_bookingpage.dart';
import 'package:vehicle_rental_app/views/admin/admin_homepage.dart';
import 'package:vehicle_rental_app/views/admin/admin_profilepage.dart';
import 'package:vehicle_rental_app/views/admin/admin_vehiclepage.dart';

class AdminMainpage extends StatefulWidget {
  const AdminMainpage({super.key});

  @override
  State<AdminMainpage> createState() => _AdminMainpageState();
}

class _AdminMainpageState extends State<AdminMainpage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    //Initialize pages once
    _pages = [
      const AdminHomepage(),
      const AdminBookingsPage(),
      const AdminVehiclepage(),
      const AdminProfilepage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        index: _currentIndex,
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.calendar_month, color: Colors.white),
          Icon(Icons.directions_car, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
    );
  }
}
