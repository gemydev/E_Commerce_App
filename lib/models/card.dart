import 'package:E_commerce/database/const_titles.dart';

class CreditCard {
  int id;
  String cardNumber;
  String expirationDate;
  String ccv;

  CreditCard({this.cardNumber, this.expirationDate, this.ccv});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[CARD_ID] = id;
    }
    map[CARD_NUMBER] = cardNumber;
    map[CARD_EXPIRATION_DATE] = expirationDate;
    map[CARD_CVV] = ccv;
    return map;
  }

  CreditCard.fromMap(Map<String, dynamic> map) {
    this.id = map[CARD_ID];
    this.cardNumber = map[CARD_NUMBER];
    this.expirationDate = map[CARD_EXPIRATION_DATE];
    this.ccv = map[CARD_CVV];
  }
}
