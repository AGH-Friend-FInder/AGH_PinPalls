import 'package:flutter/material.dart';

import 'screens/groups_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/map_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const PinPalsApp());
}

class PinPalsApp extends StatelessWidget {
  const PinPalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGH PinPals',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/groups',
      routes: {
        '/login': (context) => LoginScreen(),
        '/map': (context) => const MapScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/groups': (context) => const GroupsScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
