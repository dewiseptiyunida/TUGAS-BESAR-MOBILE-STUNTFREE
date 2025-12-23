import 'package:dio/dio.dart';
import '../models/artikel.dart';

class ArtikelService {
  static const String baseUrl =
      'https://pgdqcupfmoofpdjzpftf.supabase.co/rest/v1';

  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBnZHFjdXBmbW9vZnBkanpwZnRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY0MjA3NjcsImV4cCI6MjA4MTk5Njc2N30.7zsUy2SdwUZS1V-pnOlpo6vWYaMMPRNva_kvyDs_zTs';

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'apikey': anonKey,
        'Authorization': 'Bearer $anonKey',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<List<Artikel>> fetchArtikel() async {
    final response = await dio.get(
      '/stuntfree',
      queryParameters: {'select': '*', 'order': 'created_at.desc'},
    );

    return (response.data as List).map((e) => Artikel.fromJson(e)).toList();
  }
}
