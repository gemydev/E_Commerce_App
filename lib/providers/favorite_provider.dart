import 'package:E_commerce/models/product.dart';
import 'package:flutter/material.dart';

class FavoriteData extends ChangeNotifier{
  List<Product> favoriteProducts =[];

  addToFavorite(Product product){
    favoriteProducts.add(product);
    notifyListeners();
  }

  removeFromFavorite(Product product){
    favoriteProducts.remove(product);
    notifyListeners();
  }
}