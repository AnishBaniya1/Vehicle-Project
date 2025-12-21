import 'package:flutter/material.dart';

class UserHistorypage extends StatefulWidget {
  const UserHistorypage({super.key});

  @override
  State<UserHistorypage> createState() => _UserHistorypageState();
}

class _UserHistorypageState extends State<UserHistorypage> {
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
    );
  }
}
