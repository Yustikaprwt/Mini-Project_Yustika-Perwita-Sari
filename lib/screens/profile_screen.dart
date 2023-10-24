import 'package:flutter/material.dart';
import 'package:mini_project/components/navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({required this.username, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ${widget.username}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 3,
          onItemTapped: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/favorite');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/chat');
            }
          }),
    );
  }
}
