import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/core/resources/resource.dart';
import 'package:vehicle_rental_app/core/services/secure_storage.dart';
import 'package:vehicle_rental_app/views/admin/admin_mainpage.dart';
import 'package:vehicle_rental_app/views/auth/login_page.dart';
import 'package:vehicle_rental_app/views/user/user_mainpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SecureStorageService _storageService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final String? isLoggedIn = await _storageService.readValue('islogin');

    if (isLoggedIn == 'true') {
      final String? role = await _storageService.readValue('role');

      if (!mounted) return;
      if (role == 'ADMIN') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdminMainpage()),
        );
      } else if (role == 'USER') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserMainpage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid user role'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // User not logged in, navigate to login
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.splashImg, height: 150),
              Text(
                'Vehicle Rental App',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  letterSpacing: 2,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Find your ride, anytime, anywhere!',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 30),
              CircularProgressIndicator(color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
