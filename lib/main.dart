import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'models/artikel.dart';

import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/imagepick_viewmodel.dart';
import 'viewmodels/artikel_viewmodel.dart';
import 'viewmodels/chat_viewmodel.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/home_viewmodel.dart';

import 'widgets/theme_controller.dart';

import 'views/screen/home_page.dart';
import 'views/screen/login_screen.dart';
import 'views/profile/profile_page.dart';
import 'views/profile/detail_profile_page.dart';
import 'views/profile/edit_profile_page.dart';
import 'views/chat/chat_page.dart';
import 'views/artikel/artikel_page.dart';
import 'views/artikel/artikel_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppAuthProvider()),

        ChangeNotifierProvider(create: (_) => ImagePickProvider()),

        ChangeNotifierProvider(create: (_) => HomeViewModel()),

        ChangeNotifierProvider(
          create: (_) => ArtikelViewModel()..fetchArtikel(),
        ),

        ChangeNotifierProvider(create: (_) => ChatViewModel()),

        ChangeNotifierProvider(
          create: (_) => ProfileViewModel()..loadProfileImage(),
        ),
      ],

      child: ValueListenableBuilder(
        valueListenable: ThemeController.themeMode,
        builder: (_, mode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'StuntFree',

            themeMode: mode,

            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.pink,
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Poppins',
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF121212),
              primaryColor: Colors.pink,
              fontFamily: 'Poppins',
            ),

            routes: {
              '/login': (_) => const LoginScreen(),
              '/home': (_) => const HomePage(),
              '/profile': (_) => const ProfilePage(),
              '/detail_profile': (_) => const DetailProfilePage(),
              '/edit_profile': (_) => const EditProfilePage(),
              '/chat': (_) => ChatPage(),
              '/artikel': (_) => const ArticlePage(),
            },

            onGenerateRoute: (settings) {
              if (settings.name == '/artikel_detail') {
                final artikel = settings.arguments as Artikel;
                return MaterialPageRoute(
                  builder: (_) => ArtikelDetailPage(artikel: artikel),
                );
              }
              return null;
            },

            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return const HomePage();
                }
                return const LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
