import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/components/navigation_bar.dart';
import 'package:mini_project/models/favorite_product_model.dart';
import 'package:mini_project/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class DetailBlushOn extends StatefulWidget {
  final Map<String, dynamic> product;

  DetailBlushOn({required this.product, Key? key}) : super(key: key);

  @override
  State<DetailBlushOn> createState() => _DetailBlushOnState();
}

class _DetailBlushOnState extends State<DetailBlushOn> {
  bool isFavorite = false;

  void addToFavorites() {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    final favoriteProduct = FavoriteProduct(
      id: widget.product['id'].toString(),
      name: widget.product['name'],
      description: widget.product['description'],
      price: double.parse(widget.product['price']),
      imageLink: widget.product['image_link'],
    );

    if (isFavorite) {
      favoriteProvider.removeFavoriteProduct(favoriteProduct);
      print('Removed from favorites: ${favoriteProduct.name}');
    } else {
      favoriteProvider.addFavoriteProduct(favoriteProduct);
      print('Added to favorites: ${favoriteProduct.name}');
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  Future<void> _showFavoriteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
              style: const TextStyle(
                  color: Color(0xffEE6BCC), fontWeight: FontWeight.bold)),
          content: Text(
              'Do you want to ${isFavorite ? 'remove' : 'add'} this product to your favorites?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xffEE6BCC)),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                addToFavorites();
              },
              child: const Text('Confirm',
                  style: TextStyle(color: Color(0xffEE6BCC))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showFavoriteConfirmationDialog(context);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView(
            children: [
              Image.network(
                widget.product['image_link'],
                width: 350,
                height: 350,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.product['name'],
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: const Color(0xffEE6BCC)),
              ),
              const SizedBox(
                height: 7,
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Price:',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffEE6BCC)),
                  ),
                  const Icon(
                    Icons.attach_money,
                    size: 17,
                  ),
                  Text(
                    '${widget.product['price']}',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
        },
      ),
    );
  }
}
