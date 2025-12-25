import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental_app/core/providers/auth_provider.dart';
import 'package:vehicle_rental_app/core/resources/resource.dart';
import 'package:vehicle_rental_app/views/user/user_verifyotppage.dart';

class UserForgetpasswordpage extends StatefulWidget {
  const UserForgetpasswordpage({super.key});

  @override
  State<UserForgetpasswordpage> createState() => _UserForgetpasswordpageState();
}

class _UserForgetpasswordpageState extends State<UserForgetpasswordpage> {
  late final TextEditingController _emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const double _fieldWidth = 350;
  static const double _imageSize = 200;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleForgetPassword() async {
    // Validate email field
    if (!_formKey.currentState!.validate()) return;

    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.forgetpassword(email: _emailController.text.trim());

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserVerifyotppage(
            email: _emailController.text.trim(), // Pass email to verify page
          ),
        ),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully! Check your email.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Failed to send OTP'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.04),

                // Forget Password Image
                SvgPicture.asset(
                  AppImage.forgetImg,
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Instruction Text
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Text(
                    'Enter your email address and we\'ll send you an OTP.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Email Input Field
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        enabled: !authProvider.isLoading,
                        onFieldSubmitted: (_) => _handleForgetPassword(),
                        validator: _validateEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'Email',
                          hintText: 'Enter your email address',
                          prefixIcon: const Icon(Icons.email_rounded),
                          filled: true,
                          fillColor: Colors.grey[50],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Send OTP Button
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
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
                              : _handleForgetPassword,
                          label: authProvider.isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Send OTP',
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

                SizedBox(height: screenHeight * 0.03),

                // Help Text
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _fieldWidth),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.blue[700],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'If you don\'t receive an email within a few minutes, please check your spam folder.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue[900],
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
