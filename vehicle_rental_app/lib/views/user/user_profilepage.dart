import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/auth_provider.dart';
import 'package:vehicle_rental_app/core/resources/resource.dart';
import 'package:vehicle_rental_app/core/services/secure_storage.dart';
import 'package:vehicle_rental_app/views/auth/login_page.dart';
import 'package:vehicle_rental_app/core/widgets/custom_card.dart';

class UserProfilepage extends StatefulWidget {
  const UserProfilepage({super.key});

  @override
  State<UserProfilepage> createState() => _UserProfilepageState();
}

class _UserProfilepageState extends State<UserProfilepage> {
  final SecureStorageService _storageService = SecureStorageService();
  String _name = '';
  String _email = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserProfile();
    });
  }

  Future<void> _loadUserProfile() async {
    try {
      final authProvider = context.read<AuthProvider>();
      await authProvider.me();

      final name = await _storageService.readValue('name');
      final email = await _storageService.readValue('email');

      if (mounted) {
        setState(() {
          _name = name ?? 'Unknown';
          _email = email ?? 'No email';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false; // Set loading to false on error
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to load profile: $e')));
      }
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
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.04),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.15,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              screenWidth * 0.15,
                            ),
                            child: Image.asset(
                              AppImage.profileImg,
                              height: screenWidth * 0.3,
                              width: screenWidth * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        CustomCard(
                          children: [
                            Icon(Icons.person, size: screenWidth * 0.06),
                            SizedBox(width: screenWidth * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  _name,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CustomCard(
                          children: [
                            Icon(Icons.email, size: screenWidth * 0.06),
                            SizedBox(width: screenWidth * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  _email,
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CustomCard(
                          children: [
                            Icon(Icons.lock, size: screenWidth * 0.06),
                            SizedBox(width: screenWidth * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: screenWidth * 0.04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Change Password',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CustomCard(
                          children: [
                            Icon(Icons.logout, size: screenWidth * 0.06),
                            SizedBox(width: screenWidth * 0.05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Logout',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: screenWidth * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final shouldLogout =
                                            await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Logout'),
                                                content: const Text(
                                                  'Do you want to logout?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                          context,
                                                          false,
                                                        ),
                                                    child: const Text('No'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                          context,
                                                          true,
                                                        ),
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                        if (shouldLogout == true) {
                                          await _storageService.clearAll();
                                          if (context.mounted) {
                                            Navigator.of(
                                              context,
                                            ).pushReplacement(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
