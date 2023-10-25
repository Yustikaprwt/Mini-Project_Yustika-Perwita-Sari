import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/components/navigation_bar.dart';
import 'package:mini_project/helper/database_helper.dart';
import 'package:mini_project/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/authentication/authentication_service.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({required this.username, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isVisible = false;
  late DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.username;
    databaseHelper = DatabaseHelper();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> updateAccount(String newUsername, String newPassword) async {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;

    if (user != null) {
      int userId = user.usrId ?? 0;
      await databaseHelper.updateAccount(userId, newUsername, newPassword);

      authService.setUser(UserModel(
        usrId: userId,
        usrName: newUsername,
        usrPassword: newPassword,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
        ),
      );

      setState(() {
        usernameController.text = newUsername;
        passwordController.text = newPassword;
        confirmPasswordController.text = newPassword;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User is null. Unable to update account.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.pink),
                    title: const Text('Logout',
                        style: TextStyle(color: Colors.pink)),
                    onTap: () {
                      final authService = context.read<AuthenticationService>();
                      authService.logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: '${user?.usrName ?? widget.username}',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: const Color(0xffEED7F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xffEED7F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: !isVisible,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xffEED7F9),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: !isVisible,
              ),
              const SizedBox(height: 25.0),
              Container(
                height: 55,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      final updatedUsername = usernameController.text;
                      final updatedPassword = passwordController.text;
                      final updatedConfirmPassword =
                          confirmPasswordController.text;

                      if (updatedPassword == updatedConfirmPassword) {
                        updateAccount(updatedUsername, updatedPassword);

                        usernameController.text = '';
                        passwordController.text = '';
                        confirmPasswordController.text = '';
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Password and Confirm Password do not match'),
                          ),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffEE6BCC)),
                    ),
                    child: const Center(
                      child: Text(
                        'Save Edit',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
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
        },
      ),
    );
  }
}
