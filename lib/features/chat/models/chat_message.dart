class ChatMessage {
  final String text;
  final bool isMe;
  final String sender;
  bool isRead;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.sender,
    this.isRead = false,
  });
}
