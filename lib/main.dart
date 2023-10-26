import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/authentication/login.dart';
import 'package:mini_project/authentication/register.dart';
import 'package:mini_project/providers/authentication_service.dart';
import 'package:mini_project/providers/makeup_provider.dart';
import 'package:mini_project/screens/chat_recommendation.dart';
import 'package:mini_project/screens/favorite_screen.dart';
import 'package:mini_project/screens/home_page.dart';
import 'package:mini_project/screens/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationService>(
        create: (context) => AuthenticationService(),
      ),
      ChangeNotifierProvider<MakeupRecommendationProvider>(
        create: (context) => MakeupRecommendationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beautyou',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomePage(username: ''),
        '/favorite': (context) => const FavoriteScreen(),
        '/chat': (context) => const ChatRecommendation(),
        '/profile': (context) => const ProfileScreen(username: ''),
      },
    );
  }
}
