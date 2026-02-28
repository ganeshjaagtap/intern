import 'package:flutter/material.dart';

class MentorDashboardScreen extends StatelessWidget {
  const MentorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF64A9F6);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

     

      /// 📄 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            /// 👋 WELCOME
            Text(
              "Welcome Back, Dr. Kundlikar 👋",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            /// 🚨 NEEDS ATTENTION
            _NeedsAttentionCard(),

            SizedBox(height: 16),

            /// 📊 STATS
            _StatsSection(),

            SizedBox(height: 20),

            /// 🔘 ACTION BUTTONS
            MentorActionTile(
              icon: Icons.fact_check_outlined,
              title: "Review Approvals",
            ),
            MentorActionTile(
              icon: Icons.bar_chart_rounded,
              title: "View Reports",
            ),
            MentorActionTile(
              icon: Icons.chat_bubble_outline,
              title: "Message Mentor",
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
      
    );
  }
}

/* ----------------------------- WIDGETS ----------------------------- */

class _NeedsAttentionCard extends StatelessWidget {
  const _NeedsAttentionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7DADA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFF4B4B4),
            child: Icon(Icons.warning_amber_rounded, color: Colors.red),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Needs Attention",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "4 students at risk · 2 pending approvals",
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Review"),
          )
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔹 First Row
        Row(
          children: [
            Expanded(
              child: _statButton(
                context,
                "Total Students",
                const MiniStatCard(
                  icon: Icons.bar_chart,
                  value: "90",
                  label: "Total Students",
                  bg: Color(0xFFD9ECFF),
                  iconColor: Colors.blue,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statButton(
                context,
                "Active Internships",
                const MiniStatCard(
                  icon: Icons.description,
                  value: "7",
                  label: "Active Internships",
                  bg: Color(0xFFFFF2CC),
                  iconColor: Colors.orange,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// 🔹 Second Row
        Row(
          children: [
            Expanded(
              child: _statButton(
                context,
                "Completed",
                const MiniStatCard(
                  icon: Icons.check_circle,
                  value: "60",
                  label: "Completed",
                  bg: Color(0xFFFFE6D9),
                  iconColor: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statButton(
                context,
                "Pending Approvals",
                const MiniStatCard(
                  icon: Icons.pending_actions,
                  value: "7",
                  label: "Pending Approvals",
                  bg: Color(0xFFDFF5EA),
                  iconColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 🔹 Clickable Wrapper
  Widget _statButton(BuildContext context, String title, Widget child) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$title coming soon 🚀"),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: child,
      ),
    );
  }
}



  /// 🔹 Reusable Button Style
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }



/// 🔹 MINI STAT CARD
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 ACTION TILE
class MentorActionTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const MentorActionTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF6F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFB2E9DC),
          child: Icon(icon, color: Colors.black),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$title coming soon 🚀"),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}
