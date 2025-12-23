import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/header.dart';
import '../../models/artikel.dart';
import '../../viewmodels/artikel_viewmodel.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ArtikelViewModel>().fetchArtikel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: Header(
        title: "Artikel",
        startColor: const Color(0xFFFF8383),
        endColor: bgColor,
        onBack: () {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
      ),
      body: Consumer<ArtikelViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.artikel.isEmpty) {
            return const Center(
              child: Text("Belum ada artikel", style: TextStyle(fontSize: 16)),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vm.artikel.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final artikel = vm.artikel[index];
              return _buildCardArtikel(context, artikel);
            },
          );
        },
      ),
    );
  }

  Widget _buildCardArtikel(BuildContext context, Artikel artikel) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/artikel_detail', arguments: artikel);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                artikel.gambar,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel.judul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    artikel.isi,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
