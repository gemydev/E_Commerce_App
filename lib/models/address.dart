import 'package:E_commerce/database/const_titles.dart';

class Address {
  int id;
  String addressLane;
  String city;
  String postalCode;

  Address({this.addressLane, this.city, this.postalCode});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[ADDRESS_ID] = id;
    }
    map[ADDRESS_LANE] = addressLane;
    map[CITY] = city;
    map[POSTAL_CODE] = postalCode;
    return map;
  }

  Address.fromMapObject(Map<String, dynamic> map) {
    this.id = map[ADDRESS_ID];
    this.addressLane = map[ADDRESS_LANE];
    this.city = map[CITY];
    this.postalCode = map[POSTAL_CODE];
  }
}