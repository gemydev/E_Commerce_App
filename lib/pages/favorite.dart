import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/app_bar_functions.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/item_details.dart';
import 'package:E_commerce/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteProducts = Provider.of<FavoriteData>(context).favoriteProducts;
    return Scaffold(
        appBar: PreferredSize(
            child: Column(
              children: <Widget>[
                normalAppBar(context),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Favorite",
                        style: TextStyle(
                            color: LIGHT_BLACK,
                            fontSize: 25,
                            letterSpacing: 1.5),
                      ),
                    ))
              ],
            ),
            preferredSize: Size.fromHeight(100)),
        body: Padding(
          padding: const EdgeInsets.only(left: 15 , right: 15 , top: 10),
          child: GridView.builder(
              itemCount: favoriteProducts.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 16 , childAspectRatio: 0.8),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    normalShift(context, ItemDetail(product: favoriteProducts[index]));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage(
                                      "${favoriteProducts[index].imagePath}",
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 2, left: 2, top: 5, bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${favoriteProducts[index].name}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("\$${favoriteProducts[index].price}"),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
