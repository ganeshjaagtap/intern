import 'package:flutter/material.dart';
import 'student_list_screen.dart';
import 'active_internships_screen.dart';
import 'completed_internships_screen.dart';
import 'review_approvals_screen.dart';

class MentorDashboardScreen extends StatelessWidget {
  const MentorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const _NeedsAttentionCard(),

              const SizedBox(height: 30),

              const Text(
                "Internship Overview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _StatsSection(),

              const SizedBox(height: 30),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _QuickActions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        MentorActionTile(
          icon: Icons.fact_check_outlined,
          title: "Review Approvals",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReviewApprovalsScreen(),
              ),
            );
          },
        ),

        const MentorActionTile(
          icon: Icons.bar_chart_rounded,
          title: "View Reports",
        ),

        const MentorActionTile(
          icon: Icons.chat_bubble_outline,
          title: "Message Students",
        ),
      ],
    );
  }
}

class _StatsSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [

            Expanded(
              child: _buildStatCard(
                context,
                title: "Total Students",
                value: "90",
                icon: Icons.groups,
                color: Colors.blue,
                screen: const StudentListScreen(department: "IoT"),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: _buildStatCard(
                context,
                title: "Active Now",
                value: "24",
                icon: Icons.bolt,
                color: Colors.orange,
                screen: const ActiveInternshipsScreen(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [

         Expanded(
  child: _buildStatCard(
    context,
    title: "Completed",
    value: "60",
    icon: Icons.check_circle_outline,
    color: Colors.green,
    screen:  const CompletedInternshipsScreen(),
  ),
),

            const SizedBox(width: 15),

            Expanded(
              child: _buildStatCard(
                context,
                title: "Pending",
                value: "06",
                icon: Icons.hourglass_empty,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }

Widget _buildStatCard(
  BuildContext context, {
  required String title,
  required String value,
  required IconData icon,
  required Color color,
  Widget? screen,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(18),
    onTap: () {
      if (screen != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      }
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 15),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title),
        ],
      ),
    ),
  );
}
}

class _NeedsAttentionCard extends StatelessWidget {
  const _NeedsAttentionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 10),
          Text("4 students at risk · 2 pending"),
        ],
      ),
    );
  }
}

class MentorActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const MentorActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: onTap,
      ),
    );
  }
}