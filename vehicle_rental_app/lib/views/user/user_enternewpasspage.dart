import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/auth_provider.dart';
import 'package:vehicle_rental_app/core/resources/resource.dart';
import 'package:vehicle_rental_app/views/auth/login_page.dart';

class UserEnternewpasspage extends StatefulWidget {
  const UserEnternewpasspage({super.key, required this.email});

  final String email;

  @override
  State<UserEnternewpasspage> createState() => _UserEnternewpasspageState();
}

class _UserEnternewpasspageState extends State<UserEnternewpasspage> {
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  static const double _fieldWidth = 350;
  static const double _imageSize = 180;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSetPassword() async {
    // Validate form
    if (!_formKey.currentState!.validate()) return;

    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.setnewpass(
        email: widget.email,
        newpassword: _newPasswordController.text.trim(),
        confirmpassword: _confirmPasswordController.text.trim(),
      );

      if (!mounted) return;

      // Show success dialog
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? 'Failed to reset password',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Password Reset Successful',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Your password has been reset successfully. You can now login with your new password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false, // Remove all previous routes
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text(
              'Go to Login',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Reset Password',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: authProvider.isLoading
                  ? null
                  : () => Navigator.pop(context),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.04),

                // Reset Password Image
                SvgPicture.asset(
                  AppImage.enterImg,
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Title Text
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Text(
                    'Create New Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Subtitle Text
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Text(
                    'Your new password must be different from previously used passwords.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // New Password Field
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return TextFormField(
                        controller: _newPasswordController,
                        obscureText: !_isNewPasswordVisible,
                        enabled: !authProvider.isLoading,
                        validator: _validatePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'New Password',
                          hintText: 'Enter new password',
                          prefixIcon: const Icon(Icons.lock_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isNewPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isNewPasswordVisible = !_isNewPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Confirm Password Field
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        enabled: !authProvider.isLoading,
                        validator: _validateConfirmPassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Confirm Password',
                          hintText: 'Re-enter new password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Password Requirements Info Box
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Colors.blue[700],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Password Requirements:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildRequirement('At least 8 characters'),
                        _buildRequirement('Contains uppercase & lowercase'),
                        _buildRequirement('Contains numbers'),
                        _buildRequirement('Contains special characters'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Set Password Button
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor: Colors.grey.shade400,
                            elevation: 2,
                          ),
                          onPressed: authProvider.isLoading
                              ? null
                              : _handleSetPassword,
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Set Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: Colors.blue[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.blue[900]),
            ),
          ),
        ],
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain uppercase letters';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain lowercase letters';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain numbers';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain special characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
