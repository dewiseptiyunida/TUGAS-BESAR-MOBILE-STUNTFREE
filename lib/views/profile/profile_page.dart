import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/theme_controller.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../viewmodels/profile_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (_, themeMode, __) {
        final isDark = themeMode == ThemeMode.dark;

        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: Consumer<ProfileViewModel>(
            builder: (context, vm, _) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFF8383),
                          Theme.of(context).scaffoldBackgroundColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: vm.pickProfileImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: vm.profileImage != null
                                ? FileImage(vm.profileImage!)
                                : const AssetImage('assets/profile.png')
                                      as ImageProvider,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          vm.user?.displayName ?? "User",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Detail Profil"),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () =>
                                Navigator.pushNamed(context, '/detail_profile'),
                          ),
                          const Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Mode",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Switch(
                                  value: isDark,
                                  onChanged: ThemeController.toggleTheme,
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text("Logout"),
                            onTap: () async {
                              await vm.logout(context);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: BottomNavBar(
            isDark: isDark,
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFFF8383),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
        );
      },
    );
  }
}
