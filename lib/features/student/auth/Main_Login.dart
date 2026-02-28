import 'package:flutter/material.dart';
import 'package:flutter_application_2/university_mentor/layout/mentor_main_layout.dart';

import 'package:flutter_application_2/university_mentor/layout/mentor_main_layout.dart';
import 'package:flutter_application_2/university_mentor/screens/mentor_dashboard_screen.dart';
import 'package:flutter_application_2/features/student/dashboard/StudentDashboardScreen.dart';
import 'package:flutter_application_2/features/student/auth/CreateAccountScreen.dart';
import 'package:flutter_application_2/university_mentor/layout/mentor_main_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool obscurePassword = true;
  bool startAnimation = false;

  final Color primaryBlue = const Color(0xFF1976D2);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _animation = Tween<double>(begin: -200, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => startAnimation = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// 🔐 LOGIN HANDLER
  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 🛑 Empty validation
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter email/username and password"),
        ),
      );
      return;
    }

    // 👨‍🏫 Mentor login
    if (email == "mn" && password == "123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MentorMainLayout(),
        ),
      );
      return;
    }

    // 👨‍🎓 Student login
    if (email == "st" && password == "st123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const StudentDashboardScreen(),
        ),
      );
      return;
    }

    // ❌ Invalid credentials
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Invalid login credentials"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔁 BACKGROUND IMAGE
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value, 0),
                child: child,
              );
            },
            child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width * 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/collage_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// 🔷 MAIN UI
          SafeArea(
            child: Stack(
              children: [
                /// LOGO
                AnimatedAlign(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  alignment:
                      startAnimation ? Alignment.topCenter : Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.school, size: 70, color: primaryBlue),
                        const SizedBox(height: 10),
                        Text(
                          "Intern Tracker",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// LOGIN CARD
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: startAnimation ? 1 : 0,
                  child: IgnorePointer(
                    ignoring: !startAnimation,
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            const SizedBox(height: 200),

                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxWidth: 480),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE3F2FD),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        labelText: "Username / Email",
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: primaryBlue,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: obscurePassword,
                                      decoration: InputDecoration(
                                        labelText: "Password",
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: primaryBlue,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: primaryBlue,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              obscurePassword =
                                                  !obscurePassword;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: handleLogin,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryBlue,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            /// SIGN UP
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CreateAccountScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "New user? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
