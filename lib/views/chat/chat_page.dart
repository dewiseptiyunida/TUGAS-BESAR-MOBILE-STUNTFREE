import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/chat_viewmodel.dart';
import '../../widgets/chat/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chat';
  ChatPage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFFF8383), theme.scaffoldBackgroundColor],
              stops: const [0.3, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
            Text(
              "StuntFree AI",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: vm.messages.length + (vm.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == vm.messages.length && vm.isTyping) {
                  return const ChatBubble(
                    text: "AI sedang mengetik...",
                    isUser: false,
                    isTyping: true,
                  );
                }

                final msg = vm.messages[index];
                return ChatBubble(text: msg.content, isUser: msg.isUser);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            color: theme.cardColor,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          theme.inputDecorationTheme.fillColor ??
                          (isDark ? Colors.grey[900] : Colors.white),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black54 : Colors.black26,
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      style: theme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                        hintText: "Tanyakan disini...",
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    vm.sendMessage(_controller.text);
                    _controller.clear();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8EFFC),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black54 : Colors.black26,
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      "Kirim",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
