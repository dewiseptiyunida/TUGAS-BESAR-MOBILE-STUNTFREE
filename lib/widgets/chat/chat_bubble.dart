import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isTyping;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isUser,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isUser
        ? (isDark ? const Color(0xFF1E88E5) : const Color(0xFFC8EFFC))
        : (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F1F1));

    final textColor = isDark ? Colors.white : Colors.black87;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: isUser ? const Radius.circular(14) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(14),
          ),
        ),
        child: isTyping
            ? Text(
                "Stuntfree AI sedang mengetik...",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: textColor.withOpacity(0.7),
                ),
              )
            : Text(text, style: TextStyle(fontSize: 14, color: textColor)),
      ),
    );
  }
}
