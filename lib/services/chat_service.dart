import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String baseUrl = "http://192.168.1.6:5000";

  static Future<String> sendMessage(String message) async {
    final url = Uri.parse("$baseUrl/api/chat");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": message}),
    );
    final data = jsonDecode(response.body);
    return data["ai_response"] ?? "";
  }
}
