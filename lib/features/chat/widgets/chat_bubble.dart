import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../utils/chat_colors.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isGroupChat;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isGroupChat,
  });

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe
              ? ChatColors.myMessage
              : ChatColors.otherMessage,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            /// ✅ SENDER NAME (GROUP CHAT ONLY)
            if (isGroupChat && !isMe)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  message.sender,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ChatColors.textDark,
                  ),
                ),
              ),

            /// MESSAGE TEXT
            Text(
              message.text,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
