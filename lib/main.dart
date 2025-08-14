// main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/launch_screen.dart';
import 'screens/name_setup_screen.dart';
import 'services/storage_service.dart';

void main() {
  runApp(QuranTrackerApp());
}

class QuranTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Memorization Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppInitializer(),
    );
  }
}

class AppInitializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageService.getUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LaunchScreen();
        }

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return NameSetupScreen();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
