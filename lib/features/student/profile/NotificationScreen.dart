import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<_NotificationItem> notifications = [
    _NotificationItem(
      title: "Report Approved",
      message: "Your Week 2 Progress Report has been approved.",
      time: "2h ago",
      isRead: false,
      icon: Icons.check_circle,
      color: Colors.green,
    ),
    _NotificationItem(
      title: "Attendance Alert",
      message: "Your attendance is below 90% this month.",
      time: "1 day ago",
      isRead: false,
      icon: Icons.warning_amber,
      color: Colors.orange,
    ),
    _NotificationItem(
      title: "Deadline Reminder",
      message: "Week 8 progress report is due in 3 days.",
      time: "2 days ago",
      isRead: true,
      icon: Icons.calendar_today,
      color: Colors.redAccent,
    ),
    _NotificationItem(
      title: "Mentor Message",
      message: "Your mentor has sent you a message.",
      time: "3 days ago",
      isRead: true,
      icon: Icons.chat_bubble_outline,
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      // APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BB6FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "NOTIFICATIONS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var n in notifications) {
                  n.isRead = true;
                }
              });
            },
            child: const Text(
              "Mark all read",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),

      // BODY
      body: notifications.isEmpty
          ? _emptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _notificationCard(notifications[index]);
              },
            ),
    );
  }

  /// NOTIFICATION CARD
  Widget _notificationCard(_NotificationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.isRead ? Colors.white : const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ICON
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),

          const SizedBox(width: 12),

          // CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: item.isRead ? Colors.black : Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.message,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // READ DOT
          if (!item.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  /// EMPTY STATE
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.notifications_off, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            "No notifications yet",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            "You're all caught up 🎉",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// ============================
/// MODEL
/// ============================
class _NotificationItem {
  final String title;
  final String message;
  final String time;
  bool isRead;
  final IconData icon;
  final Color color;

  _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
    required this.icon,
    required this.color,
  });
}
