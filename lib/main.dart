import 'package:agh_pin_palls/screens/groups_screen.dart';
import 'package:agh_pin_palls/screens/create_group_screen.dart';
import 'package:agh_pin_palls/screens/profile_screen.dart';
import 'package:agh_pin_palls/provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'screens/map/map_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PinProvider()),
        ChangeNotifierProvider(create: (context) => GroupProvider()),
      ],
      child: const PinPalsApp(),
    ),
  );
}

class PinPalsApp extends StatelessWidget {
  const PinPalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGH PinPals',
      theme: ThemeData(primarySwatch: Colors.green),
      // Zawsze startuje od ekranu logowania
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/map': (context) => MapScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/groups': (context) => const GroupsScreen(),
        '/groups/create': (context) => const CreateGroupsScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
