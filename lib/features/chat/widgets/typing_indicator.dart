import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: const [
          CircleAvatar(radius: 4),
          SizedBox(width: 4),
          CircleAvatar(radius: 4),
          SizedBox(width: 4),
          CircleAvatar(radius: 4),
        ],
      ),
    );
  }
}
