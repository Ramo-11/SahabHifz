import 'package:flutter/material.dart';

class MotivationalQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Text(
            "\"And We have certainly made the Quran easy for remembrance, so is there any who will remember?\"",
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.blue[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "- Quran 54:17",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.blue[600],
            ),
          ),
        ],
      ),
    );
  }
}
