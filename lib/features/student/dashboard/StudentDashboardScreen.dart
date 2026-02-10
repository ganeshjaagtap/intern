import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/student/profile/NotificationScreen.dart';
import 'package:flutter_application_2/features/chat/screens/chat_selection_screen.dart';
import '../profile/SettingsScreen.dart';
import '../attendance/AttendanceScreen.dart';
import '../reports/ReportScreen.dart';

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      // APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BB6FF),
        elevation: 0,
        title: const Text(
          "INTERN TRACKER",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push (
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationScreen(),
                ),
              );
              
            },
          )
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Welcome back, Student!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // DEADLINE ALERT
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD6D6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: Colors.red),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deadline in 3 days",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Week 8 progress report is due soon",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {},
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 18),

            // STATS
            Row(
              children: const [
                Expanded(
                  child: MiniStatCard(
                    icon: Icons.bar_chart,
                    value: "1",
                    label: "Active",
                    bg: Color(0xFFD9ECFF),
                    iconColor: Colors.blue,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: MiniStatCard(
                    icon: Icons.description,
                    value: "7",
                    label: "Reports",
                    bg: Color(0xFFFFF2CC),
                    iconColor: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                Expanded(
                  child: MiniStatCard(
                    icon: Icons.access_time,
                    value: "98",
                    label: "Days Left",
                    bg: Color(0xFFFFE6D9),
                    iconColor: Colors.deepOrange,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: MiniStatCard(
                    icon: Icons.show_chart,
                    value: "7",
                    label: "Progress",
                    bg: Color(0xFFDFF5EA),
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            const Text(
              "Internship Progress",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Frontend Developer Intern",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Techcorp Solutions",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.teal),
                  )
                ],
              ),
            ),

            const SizedBox(height: 22),

            // QUICK ACTIONS (ONLY 2)
           

            const SizedBox(height: 12),

           

            const SizedBox(height: 60),
          ],
        ),
      ),

      // ✅ CUSTOM BOTTOM NAV WITH CHAT
      bottomNavigationBar: const _CustomBottomNav(currentIndex: 0),
    );
  }
}

////////////////////////////////////////////////////////////
/// CUSTOM BOTTOM NAV
////////////////////////////////////////////////////////////
class _CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const _CustomBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        children: [

          Container(
            height: 56,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                _navItem(
                  icon: Icons.home,
                  label: "Home",
                  active: currentIndex == 0,
                  onTap: () {},
                ),

                _navItem(
                  icon: Icons.check_circle_outline,
                  label: "Attendance",
                  active: currentIndex == 1,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AttendanceScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 60),

                _navItem(
                  icon: Icons.description,
                  label: "Report",
                  active: currentIndex == 2,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ReportScreen(),
                      ),
                    );
                  },
                ),

                _navItem(
                  icon: Icons.settings,
                  label: "Settings",
                  active: currentIndex == 3,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // CENTER CHAT
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatSelectionScreen(),
                  ),
                );
              },
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool active,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: active ? Colors.blue : Colors.grey),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: active ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// ACTION CARD (WHITE, NOT BLUE)
////////////////////////////////////////////////////////////
class ActionCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const ActionCard({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// MINI STAT CARD
////////////////////////////////////////////////////////////
class MiniStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color bg;
  final Color iconColor;

  const MiniStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.bg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
