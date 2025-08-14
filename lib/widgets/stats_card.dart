import 'package:flutter/material.dart';
import '../models/quran_data.dart';

class StatsCard extends StatelessWidget {
  final int completedPages;

  const StatsCard({Key? key, required this.completedPages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedJuz = QuranData.getCompletedJuzCount(completedPages);
    final completedHizb = QuranData.getCompletedHizbCount(completedPages);

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pages:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[700],
                ),
              ),
              Text(
                "$completedPages / ${QuranData.totalPages}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      "Juz",
                      style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                    ),
                    Text(
                      "$completedJuz / 30",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple[200]!),
                ),
                child: Column(
                  children: [
                    Text(
                      "Hizb",
                      style: TextStyle(fontSize: 14, color: Colors.purple[700]),
                    ),
                    Text(
                      "$completedHizb / 60",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
