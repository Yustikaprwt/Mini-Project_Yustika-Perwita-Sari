import 'package:flutter/material.dart';
import 'package:mini_project/components/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/authentication/authentication_service.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({required this.username, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ${user?.usrName ?? widget.username}',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xffEE6BCC))),
                onPressed: () {
                  final authService = context.read<AuthenticationService>();
                  authService.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ))
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
