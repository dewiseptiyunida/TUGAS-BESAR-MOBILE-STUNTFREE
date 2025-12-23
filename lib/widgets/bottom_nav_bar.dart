import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final bool isDark;
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.isDark,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = isDark ? Colors.white : Colors.black;
    final Color inactiveColor = isDark ? Colors.grey[600]! : Colors.grey;
    final Color barColor = Theme.of(context).scaffoldBackgroundColor;
    final Color dividerColor = isDark
        ? const Color(0xFF9C9C9C)
        : Colors.grey.shade300;

    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home_outlined, 'index': 0},
      {'icon': Icons.person, 'index': 1},
      {'icon': Icons.list_alt, 'index': 2},
    ];

    return Container(
      decoration: BoxDecoration(
        color: barColor,
        border: Border(top: BorderSide(color: dividerColor, width: 1)),
      ),
      child: BottomAppBar(
        color: barColor,
        elevation: 0,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...navItems.map((item) {
              final isSelected = item['index'] == selectedIndex;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    onItemTapped(item['index']);

                    if (item['index'] == 0) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else if (item['index'] == 1) {
                      Navigator.pushReplacementNamed(context, '/profile');
                    } else if (item['index'] == 2) {
                      Navigator.pushReplacementNamed(context, '/artikel');
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item['icon'],
                        color: isSelected ? activeColor : inactiveColor,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
