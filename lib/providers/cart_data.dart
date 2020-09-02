import 'package:E_commerce/models/product.dart';
import 'package:flutter/foundation.dart';

class CartDate extends ChangeNotifier{
  List<Product> products = [];

  addProduct(Product product){
    products.add(product);
    product.quantity = 1;
    notifyListeners();
  }

  removeProduct(Product product){
    products.remove(product);
    product.quantity=1;
    notifyListeners();
  }

  double calcTotalPrice(){
    double totalPrice = 0 ;
    for(var product in products){
      totalPrice += product.quantity* double.parse(product.price);
    }
    return totalPrice;
  }



}

