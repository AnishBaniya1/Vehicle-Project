import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/views/user/user_homepage.dart';
import 'package:vehicle_rental_app/views/user/user_profilepage.dart';

class UserMainpage extends StatefulWidget {
  const UserMainpage({super.key});

  @override
  State<UserMainpage> createState() => _UserMainpageState();
}

class _UserMainpageState extends State<UserMainpage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    //Initialize pages once
    _pages = [const UserHomepage(), const UserProfilepage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        index: _currentIndex,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white),
          // Icon(Icons.shopping_bag_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
    );
  }
}
