import 'package:flutter/material.dart';
import '../../widgets/header.dart';
import '../../models/artikel.dart';

class ArtikelDetailPage extends StatelessWidget {
  final Artikel artikel;
  const ArtikelDetailPage({super.key, required this.artikel});

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: Header(
        title: "Detail Artikel",
        startColor: const Color(0xFFFF8383),
        endColor: bgColor,
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                artikel.gambar,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              artikel.judul,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 6),
                Text(artikel.createdAt, style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              artikel.isi,
              textAlign: TextAlign.justify,
              style: textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
