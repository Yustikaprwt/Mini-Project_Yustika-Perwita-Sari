import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({required this.username});

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
                  imageCard('lib/assets/foundation.jpg', 'Foundation'),
                  const SizedBox(
                    height: 5,
                  ),
                  imageCard('lib/assets/blush_on.jpg', 'Blush On'),
                  const SizedBox(
                    height: 5,
                  ),
                  imageCard('lib/assets/lipstick.jpg', 'Lipstick'),
                  const SizedBox(
                    height: 5,
                  ),
                  imageCard('lib/assets/nail_polish.jpg', 'Nail Polish'),
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

  Widget imageCard(String imagePath, String title) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: AssetImage(imagePath),
              height: 180,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {},
              ),
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
      );
}
