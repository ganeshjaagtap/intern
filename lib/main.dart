import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/student/auth/Main_Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intern Tracker',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      // ✅ App will launch LoginScreen first
      home: const LoginScreen(),
    );
  }
}