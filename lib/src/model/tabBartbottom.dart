import 'package:flutter/material.dart';

class TabBarBotton extends StatelessWidget {
  final String label;
  final Color color;
  const TabBarBotton({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
