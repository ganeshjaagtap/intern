import 'package:flutter/material.dart';
import 'package:flutter_application_2/university_mentor/screens/mentor_screen.dart';
import 'package:flutter_application_2/university_mentor/screens/companies_screen.dart';
import 'package:flutter_application_2/university_mentor/screens/mentor_dashboard_screen.dart';
import 'package:flutter_application_2/university_mentor/screens/mentor_profile_screen.dart';

class MentorMainLayout extends StatefulWidget {
  const MentorMainLayout({super.key});

  @override
  State<MentorMainLayout> createState() => _MentorMainLayoutState();
}

class _MentorMainLayoutState extends State<MentorMainLayout> {
  int _currentIndex = 0;

  // ✅ List of screens handled by the layout
  final List<Widget> _screens = [
    const MentorDashboardScreen(),
    const MentorScreen(),     
    const CompaniesScreen(),  
    const MentorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF64A9F6); // Sky Blue from your photo
    const bgLight = Color(0xFFF5F7F9);    // Professional light background

    return Scaffold(
      backgroundColor: bgLight, // ✅ Updated to match the new light theme

      /// ✅ APP BAR (Matches photo style)
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        centerTitle: false, // Left aligned title usually looks better with notifications
        title: const Text(
          "INTERN TRACKER",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      /// ✅ BODY SWITCHING (IndexedStack keeps screen state alive)
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      /// ✅ FLOATING MODERN BOTTOM NAV
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20), // Floating effect
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryBlue,
            unselectedItemColor: Colors.grey.shade400,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            backgroundColor: Colors.white,
            elevation: 0,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: "Hub",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_rounded),
                label: "Mentors",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business_center_rounded),
                label: "Companies",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}