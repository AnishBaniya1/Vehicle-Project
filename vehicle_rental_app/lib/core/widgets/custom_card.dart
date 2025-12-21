import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final List<Widget> children;

  const CustomCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 20),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Row(children: children),
        ),
      ),
    );
  }
}
