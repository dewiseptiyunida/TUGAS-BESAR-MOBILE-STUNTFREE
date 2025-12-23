import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/home_viewmodel.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../models/artikel.dart';
import '../artikel/artikel_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color scaffoldBackground = Theme.of(context).scaffoldBackgroundColor;
    final Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final Color cardColor = Theme.of(context).cardColor;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: const Color(0xFFFF8383),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF8383),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, '/chat');
        },
        child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomNavBar(
        isDark: isDark,
        selectedIndex: vm.selectedIndex,
        onItemTapped: vm.changeTab,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(vm, scaffoldBackground, textColor),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Artikel Populer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildArtikel(context, vm, cardColor, textColor, isDark),
            ),
            const SizedBox(height: 30),
            Image.asset("assets/images/logos.png", height: 60),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Wujudkan generasi sehat melalui sistem inovatif pencegahan stunting",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: textColor),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(HomeViewModel vm, Color bottomColor, Color textColor) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFF8383), bottomColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            radius: 45,
            backgroundImage: vm.profileImage != null
                ? FileImage(vm.profileImage!)
                : const AssetImage("") as ImageProvider,
          ),
          const SizedBox(height: 8),
          Text(
            vm.displayName,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtikel(
    BuildContext context,
    HomeViewModel vm,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.artikelList.isEmpty) {
      return const Center(child: Text("Belum ada artikel"));
    }

    final list = vm.artikelList.take(3).toList();

    return Column(
      children: list
          .map(
            (artikel) => _buildArticleCard(
              context,
              artikel,
              cardColor,
              textColor,
              isDark,
            ),
          )
          .toList(),
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    Artikel artikel,
    Color cardColor,
    Color textColor,
    bool isDark,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArtikelDetailPage(artikel: artikel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                artikel.gambar,
                width: 90,
                height: 85,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Image.asset("assets/images/artikel.jpg"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artikel.judul,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artikel.isi,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: textColor),
          ],
        ),
      ),
    );
  }
}
