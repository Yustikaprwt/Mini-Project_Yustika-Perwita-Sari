import 'package:flutter/material.dart';
import 'package:mini_project/models/favorite_product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<FavoriteProduct> _favoriteProducts = [];

  List<FavoriteProduct> get favoriteProducts => _favoriteProducts;

  void addFavoriteProduct(FavoriteProduct product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeFavoriteProduct(FavoriteProduct product) {
    _favoriteProducts.remove(product);
    notifyListeners();
  }
}
