import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/apis/blush_on_api.dart';
import 'package:mini_project/apis/eye_shadow.dart';
import 'package:mini_project/apis/foundation_api.dart';
import 'package:mini_project/apis/lipstick_api.dart';
import 'package:mini_project/apis/nail_polish_api.dart';
import 'package:mini_project/components/navigation_bar.dart';
import 'package:mini_project/providers/authentication_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({required this.username, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthenticationService>();
    final user = authService.user;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Hello, ${user?.usrName ?? widget.username}',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffEE6BCC),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Welcome back to Beautyou, a place where you can see a makeup catalog with lots of choices!',
                    style: GoogleFonts.roboto(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imageCard(context, 'lib/assets/foundation.jpg', 'Foundation',
                      const FoundationApi()),
                  const SizedBox(
                    height: 5,
                  ),
                  imageCard(context, 'lib/assets/blush_on.jpg', 'Blush On',
                      const BlushOnApi()),
                  const SizedBox(
                    height: 5,
                  ),
                  imageCard(context, 'lib/assets/lipstick.jpg', 'Lipstick',
                      const LipstickApi()),
                  const SizedBox(
                    height: 5,
                  ),
                  imageCard(context, 'lib/assets/nail_polish.jpg',
                      'Nail Polish', const NailPolishApi()),
                  imageCard(context, 'lib/assets/eyeshadow.jpg', 'Eye Shadow',
                      const EyeShadowApi())
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 0,
          onItemTapped: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/favorite');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/chat');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          }),
    );
  }

  Widget imageCard(BuildContext context, String imagePath, String title,
          Widget destinationPage) =>
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => destinationPage));
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image: AssetImage(imagePath),
                height: 180,
                fit: BoxFit.cover,
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      );
}
