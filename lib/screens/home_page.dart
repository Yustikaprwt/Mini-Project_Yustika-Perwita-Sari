import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/apis/blush_on_api.dart';
import 'package:mini_project/apis/eye_shadow.dart';
import 'package:mini_project/apis/foundation_api.dart';
import 'package:mini_project/apis/lipstick_api.dart';
import 'package:mini_project/apis/nail_polish_api.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({required this.username, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    'Hello, $username',
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xffEE6BCC),
        animationDuration: const Duration(milliseconds: 200),
        items: [
          const Icon(
            Icons.home,
            color: Color(0xffEE6BCC),
          ),
          const Icon(Icons.favorite, color: Color(0xffEE6BCC)),
          const Icon(Icons.person, color: Color(0xffEE6BCC)),
        ],
      ),
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
