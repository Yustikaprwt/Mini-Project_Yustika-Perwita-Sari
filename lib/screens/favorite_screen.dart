import 'package:flutter/material.dart';
import 'package:mini_project/components/navigation_bar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [const Text('Favorite Products')],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 1,
          onItemTapped: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/chat');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          }),
    );
  }
}
