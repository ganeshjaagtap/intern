import 'dart:async';
import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../utils/chat_colors.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/typing_indicator.dart';

class BaseChatScreen extends StatefulWidget {
  final String chatTitle;
  final bool isGroupChat;
  final String fakeReplySender;
  final VoidCallback? onOpenChat;

  const BaseChatScreen({
    super.key,
    required this.chatTitle,
    this.isGroupChat = false,
    this.fakeReplySender = "Mentor",
    this.onOpenChat,
  });

  @override
  State<BaseChatScreen> createState() => _BaseChatScreenState();
}

class _BaseChatScreenState extends State<BaseChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> messages = [];

  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    widget.onOpenChat?.call(); // 🔥 reset unread when opened
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          text: _controller.text,
          isMe: true,
          sender: "You",
          isRead: true,
        ),
      );
      _controller.clear();
      isTyping = true;
    });

    _fakeReply();
  }

  void _fakeReply() {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isTyping = false;
        messages.add(
          ChatMessage(
            text: "Got it 👍",
            isMe: false,
            sender: widget.fakeReplySender,
            isRead: false,
          ),
        );
      });
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var msg in messages) {
        msg.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.background,
      appBar: AppBar(
        title: Text(widget.chatTitle),
        backgroundColor: ChatColors.coolSky,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: "Mark all as read",
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      "No messages yet 👋",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 12),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: messages[index],
                        isGroupChat: widget.isGroupChat, // 🔥 IMPORTANT
                      );
                    },
                  ),
          ),

          if (isTyping)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: TypingIndicator(),
            ),

          ChatInputField(
            controller: _controller,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}
