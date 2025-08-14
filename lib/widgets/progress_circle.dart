import 'package:flutter/material.dart';
import '../models/quran_data.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;
  final int pagesLeft;
  final int completedPages;

  const ProgressCircle({
    Key? key,
    required this.progress,
    required this.pagesLeft,
    required this.completedPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          // Progress circle
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
            ),
          ),
          // Progress text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$pagesLeft",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              Text(
                "pages left",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Text(
                "${(progress * 100).toInt()}% complete",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
