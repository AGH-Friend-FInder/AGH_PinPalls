import 'package:agh_pin_palls/screens/groups_screen.dart';
import 'package:agh_pin_palls/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const PinPalsApp());
}

class PinPalsApp extends StatelessWidget {
  const PinPalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGH PinPals',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // Zawsze startuje od ekranu logowania
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/map': (context) => const MapScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/groups': (context) => const GroupsScreen()
      },
    );
  }
}
