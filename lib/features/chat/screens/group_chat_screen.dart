import 'package:flutter/material.dart';
import 'base_chat_screen.dart';

class GroupChatScreen extends StatelessWidget {
  const GroupChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseChatScreen(
      chatTitle: "Internship Group",
      isGroupChat: true, 
      fakeReplySender: "Group Member1",
    );
  }
}
