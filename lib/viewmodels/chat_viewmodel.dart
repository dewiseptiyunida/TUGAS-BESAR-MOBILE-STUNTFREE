import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/chat_service.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => _messages;

  bool _isTyping = false;
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _isTyping) return;

    _messages.add(ChatMessage(content: text, isUser: true));
    _isTyping = true;
    notifyListeners();

    final reply = await ChatService.sendMessage(text);

    _messages.add(ChatMessage(content: reply, isUser: false));
    _isTyping = false;
    notifyListeners();
  }
}
