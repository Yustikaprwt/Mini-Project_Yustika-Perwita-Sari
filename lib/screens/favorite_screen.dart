import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/components/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:mini_project/providers/favorite_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteProducts = favoriteProvider.favoriteProducts;

    print("Total Favorite Products: ${favoriteProducts.length}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '˚·.˚ Favorite Products ˚.·˚',
          style: GoogleFonts.poppins(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: const Color(0xffEE6BCC),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                "No favorite products in here :(",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffEE6BCC)),
              ),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final favoriteProduct = favoriteProducts[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(30),
                  color: const Color(0xffEE6BCC),
                  child: Column(
                    children: [
                      Image.network(
                        favoriteProduct.imageLink,
                        width: double.infinity,
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          favoriteProduct.name,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          favoriteProduct.description,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${favoriteProduct.price}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.favorite,
                                  color: Color.fromARGB(255, 200, 16, 3)),
                              onPressed: () {
                                favoriteProvider
                                    .removeFavoriteProduct(favoriteProduct);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
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
        },
      ),
    );
  }
}
