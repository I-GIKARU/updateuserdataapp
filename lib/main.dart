// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this contains Firebase configuration options
import 'screens/authscreen.dart';
import 'screens/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
    );
  }
}
