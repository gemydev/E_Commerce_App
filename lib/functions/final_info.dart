import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/models/address.dart';
import 'package:E_commerce/providers/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget finalInfo(Address address, BuildContext context) {
  TextStyle _headerStyle = TextStyle(fontSize: 16, color: DARK_BLACK);
  TextStyle _addressStyle = TextStyle(fontSize: 16, color: DARK_BLACK);
  double subTotalPrice = Provider.of<CartDate>(context).calcTotalPrice();
  double discount = 15.0;
  double shipping = (discount / 100) * subTotalPrice;
  double total = subTotalPrice - shipping;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            address.addressLane.toString(),
            style: _addressStyle,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            address.city.toString(),
            style: _addressStyle,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            address.postalCode.toString(),
            style: _addressStyle,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "address.phoneNumber",
            style: _addressStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Divider(
        color: GRADIENT_BEGIN,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Subtotal", style: _headerStyle),
              Text("\$${subTotalPrice.toString()}")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Discount", style: _headerStyle),
              Text("${discount.toString()}%")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Shipping", style: _headerStyle),
              Text("\$${shipping.toString()}")
            ],
          ),
        ],
      ),
      Divider(
        color: GRADIENT_BEGIN,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "total",
            style: _headerStyle,
          ),
          Text("\$${total.toString()}")
        ],
      ),
    ],
  );
}
