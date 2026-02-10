import 'package:flutter/material.dart';
import '../utils/chat_colors.dart';
import '../widgets/unread_badge.dart';
import 'faculty_chat_screen.dart';
import 'company_chat_screen.dart';
import 'group_chat_screen.dart';

class ChatPreview {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Widget screen;
  int unreadCount;

  ChatPreview({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.screen,
    required this.unreadCount,
  });
}

class ChatSelectionScreen extends StatefulWidget {
  const ChatSelectionScreen({super.key});

  @override
  State<ChatSelectionScreen> createState() => _ChatSelectionScreenState();
}

class _ChatSelectionScreenState extends State<ChatSelectionScreen> {
  late List<ChatPreview> chats;

  @override
  void initState() {
    super.initState();

    chats = [
      ChatPreview(
        title: "Faculty Mentor",
        subtitle: "Chat with your assigned faculty mentor",
        icon: Icons.school,
        color: ChatColors.jasmine,
        screen: const FacultyChatScreen(),
        unreadCount: 3,
      ),
      ChatPreview(
        title: "Company Mentor",
        subtitle: "Chat with your company supervisor",
        icon: Icons.business_center,
        color: ChatColors.tangerineDream,
        screen: const CompanyChatScreen(),
        unreadCount: 0,
      ),
      ChatPreview(
        title: "Group Chat",
        subtitle: "Chat with your internship group",
        icon: Icons.groups,
        color: ChatColors.aquamarine,
        screen: const GroupChatScreen(),
        unreadCount: 12,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.background,
      appBar: AppBar(
        title: const Text("Chats"),
        backgroundColor: ChatColors.primary,
        foregroundColor: ChatColors.textLight,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: chat.color,
                child: Icon(chat.icon, color: ChatColors.textDark),
              ),
              title: Text(
                chat.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(chat.subtitle),
              trailing: chat.unreadCount > 0
                  ? UnreadBadge(count: chat.unreadCount)
                  : const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                setState(() {
                  chat.unreadCount = 0; // 🔥 WhatsApp behavior
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => chat.screen),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
