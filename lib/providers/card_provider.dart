import 'package:E_commerce/models/card.dart';
import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier{
  List<CreditCard> creditCardsList = [];

  addCard(CreditCard creditCard){
    creditCardsList.add(creditCard);
    notifyListeners();
  }

  removeCard(CreditCard creditCard){
    creditCardsList.remove(creditCard);
    notifyListeners();
  }

}