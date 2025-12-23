import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String apiKey = "AIzaSyC4TXs1Hb1qCxExZqEiOYTNetH39vzZWI8";
  static const String url = "https://api.openai.com/v1/chat/completions";

  static Future<String> askAI(String message) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": message},
          ],
        }),
      );

      final data = jsonDecode(response.body);

      return data["choices"][0]["message"]["content"];
    } catch (e) {
      return "Maaf, terjadi kesalahan: $e";
    }
  }
}
