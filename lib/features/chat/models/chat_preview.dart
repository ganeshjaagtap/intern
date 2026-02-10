class ChatPreview {
  final String title;
  final String subtitle;
  int unreadCount;

  ChatPreview({
    required this.title,
    required this.subtitle,
    this.unreadCount = 0,
  });
}
