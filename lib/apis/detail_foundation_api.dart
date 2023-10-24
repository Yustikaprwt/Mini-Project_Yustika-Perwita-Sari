import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailFoundation extends StatefulWidget {
  final Map<String, dynamic> product;

  DetailFoundation({required this.product, Key? key}) : super(key: key);

  @override
  State<DetailFoundation> createState() => _DetailFoundationState();
}

// class FavoriteProvider with ChangeNotifier {
//   List<Map<String, dynamic>> favorites = [];

//   void addToFavorites(Map<String, dynamic> product) {
//     favorites.add(product);
//     notifyListeners();
//   }

//   void removeFromFavorites(Map<String, dynamic> product) {
//     favorites.remove(product);
//     notifyListeners();
//   }
// }

class _DetailFoundationState extends State<DetailFoundation> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
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
                        color: Color(0xffEE6BCC)),
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
    );
  }
}
