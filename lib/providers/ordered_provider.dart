import 'package:E_commerce/models/product.dart';
import 'package:flutter/material.dart';

class OrderedData extends ChangeNotifier{
  List<Product> orderedProducts = [];
  addToOrderedList(List<Product> products){
    orderedProducts.addAll(products);
    notifyListeners();
  }
}