import 'package:flutter/material.dart';
import 'package:flutter_application_2/features/chat/screens/chat_selection_screen.dart';
import 'PastAttendanceScreen.dart';
import '../dashboard/StudentDashboardScreen.dart';
import '../reports/ReportScreen.dart';
import '../profile/SettingsScreen.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      /// 🔙 APP BAR WITH BACK BUTTON
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BB6FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "ATTENDANCE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// OVERALL ATTENDANCE CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [

                  /// BIG FIXED CIRCLE
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: 0.87,
                            strokeWidth: 10,
                            backgroundColor: Colors.grey.shade200,
                            valueColor:
                                const AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                        const Text(
                          "87%",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),




                  const SizedBox(width: 24),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Overall Attendance",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "You are in good standing",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// MONTH SUMMARY
            const Text(
              "This Month Summary",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: const [
                Expanded(
                  child: CountCard(
                    title: "Present",
                    count: "18",
                    color: Colors.green,
                    icon: Icons.check_circle,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CountCard(
                    title: "Absent",
                    count: "2",
                    color: Colors.red,
                    icon: Icons.cancel,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                Expanded(
                  child: CountCard(
                    title: "Late",
                    count: "3",
                    color: Colors.orange,
                    icon: Icons.access_time,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CountCard(
                    title: "Leave",
                    count: "1",
                    color: Colors.blue,
                    icon: Icons.event_busy,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// PAST ATTENDANCE BUTTON
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PastAttendanceScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text("View Past Attendance (Month)"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF6BB6FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),

      /// 🔵 CUSTOM BOTTOM NAV (ATTENDANCE ACTIVE)
      bottomNavigationBar: const _CustomBottomNav(currentIndex: 1),
    );
  }
}

/// ============================
/// CUSTOM BOTTOM NAV
/// ============================
class _CustomBottomNav extends StatelessWidget {
  final int currentIndex; // 0=Home,1=Attendance,2=Report,3=Settings

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
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudentDashboardScreen(),
                      ),
                    );
                  },
                ),

                _navItem(
                  icon: Icons.check_circle_outline,
                  label: "Attendance",
                  active: currentIndex == 1,
                  onTap: () {},
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

          /// CENTER CHAT
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatSelectionScreen(),
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

/// ============================
/// COUNT CARD
/// ============================
class CountCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final IconData icon;

  const CountCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 6),
          Text(
            count,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
