import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/pages/shopping_cart.dart';
import 'package:E_commerce/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  final Product product;

  CustomAppBar({this.product});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool favoriteSelect = false;
  Icon favoriteBorder = Icon(Icons.favorite_border);
  Icon favorite = Icon(
    Icons.favorite,
    color: Colors.red.shade500,
  );

  @override
  Widget build(BuildContext context) {
    var favoriteProvider = Provider.of<FavoriteData>(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: DARK_BLACK,
          )),
      actions: <Widget>[
        IconButton(
          icon: favoriteSelect == true
              ? Icon(
                  Icons.favorite,
                  color: Colors.red.shade500,
                )
              : Icon(Icons.favorite_border),
          color: DARK_BLACK,
          onPressed: () {
            setState(() {
              if (favoriteSelect == true) {
                favoriteSelect = false;
                widget.product.favorite = favoriteSelect;
                favoriteProvider.addToFavorite(widget.product);
              } else {
                favoriteSelect = true;
                favoriteProvider.removeFromFavorite(widget.product);
              }
            });
          },
        ),
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: DARK_BLACK,
            ),
            onPressed: () {
              normalShift(context, ShoppingCartPage());
            }),
      ],
    );
  }
}

AppBar appBarHomeFun(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: new Icon(
          Icons.menu,
          color: DARK_BLACK,
        ),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    actions: <Widget>[
      IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: DARK_BLACK,
          ),
          onPressed: () {
            normalShift(context, ShoppingCartPage());
          }),
    ],
  );
}

AppBar normalAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: new Icon(
          Icons.arrow_back,
          color: DARK_BLACK,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    actions: <Widget>[
      IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: DARK_BLACK,
          ),
          onPressed: () {
            normalShift(context, ShoppingCartPage());
          }),
    ],
  );
}
