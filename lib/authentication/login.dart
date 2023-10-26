import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/authentication/register.dart';
import 'package:mini_project/models/user_model.dart';
import 'package:mini_project/helper/database_helper.dart';
import 'package:mini_project/screens/home_page.dart';
import 'package:mini_project/providers/authentication_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final db = DatabaseHelper();

  bool isVisible = false;
  bool isLoginTrue = false;

  final formKey = GlobalKey<FormState>();

  void login(AuthenticationService authService) async {
    var response = await db
        .login(UserModel(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      if (!mounted) return;
      authService
          .login(UserModel(usrName: username.text, usrPassword: password.text));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(username: username.text),
        ),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Consumer<AuthenticationService>(
                builder: (context, authService, child) {
                  return Column(
                    children: [
                      Text(
                        'Beautyou',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffEE6BCC),
                          shadows: [
                            const Shadow(
                              offset: Offset(2, 4),
                              color: Color(0xffFAE650),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "lib/assets/makeup.png",
                        width: 400,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffEED7F9),
                        ),
                        child: TextFormField(
                          controller: username,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "username is required";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: "Username",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(202, 82, 79, 79),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffEED7F9),
                        ),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password is required";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(202, 82, 79, 79),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffEE6BCC),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              login(authService);
                            }
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Color(0xffEE6BCC)),
                            ),
                          ),
                        ],
                      ),
                      if (isLoginTrue)
                        const Text(
                          "Username or password is incorrect",
                          style: TextStyle(color: Colors.red),
                        )
                      else
                        const SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
