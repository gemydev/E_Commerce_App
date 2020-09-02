import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/functions.dart';
import 'package:E_commerce/pages/best_sell.dart';
import 'package:E_commerce/pages/categories.dart';
import 'package:E_commerce/pages/featured.dart';
import 'package:E_commerce/pages/search_page.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomeFun(context),
      drawerScrimColor: DARK_BLACK.withOpacity(0.6),
      drawer: DrawerClass(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            section1(),
            rowOfHeads(name: "Categories", page: Categories()),
            rowOfCategories(),
            rowOfHeads(name: "Featured", page: Featured()),
            HomeListView(),
            rowOfHeads(name: "Best Sell", page: BestSell()),
            HomeListView(),
          ],
        ),
      ),
    );
  }

  Widget section1() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Hero(
        tag: "searchTag",
        child: Card(
            elevation: 7,
            child: InfoWidget(
              returnedWidget: (context, deviceInfo) {
                return Container(
                  height: deviceInfo.orientation == Orientation.portrait
                      ? deviceInfo.screenHeight * 0.075
                      : deviceInfo.screenHeight * 0.125,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.search),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            color: FIELD_NAME_COLOR,
                            width: 2.0,
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          child: TextField(
                            showCursor: false,
                            onTap: () {
                              normalShift(context, SearchPage());
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Your Product",
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Padding rowOfHeads({String name, Object page}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(color: LIGHT_BLACK, fontSize: 20),
          ),
          GestureDetector(
              onTap: () {
                normalShift(context, page);
              },
              child: Text(
                "See all",
                style: TextStyle(color: LIGHT_BLACK, fontSize: 14),
              ))
        ],
      ),
    );
  }

  Widget rowOfCategories() {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            cardOfCategories(
                categoryName: "Women",
                color: Colors.blue,
                imagePath: "assets/images/categoriesWomen.jpg"),
            SizedBox(
              width: 12,
            ),
            cardOfCategories(
                categoryName: "Man",
                color: Colors.red,
                imagePath: "assets/images/categoriesMen.jpg"),
            SizedBox(
              width: 12,
            ),
            cardOfCategories(
                categoryName: "Kids",
                color: Colors.green,
                imagePath: "assets/images/categoriesKids.jpg")
          ],
        ),
      ),
    );
  }

  Widget cardOfCategories(
      {String imagePath, Color color, String categoryName}) {
    return InfoWidget(
      returnedWidget: (context, deviceInfo) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Container(
            height: deviceInfo.orientation == Orientation.portrait
                ? deviceInfo.screenHeight * 0.09
                : deviceInfo.screenHeight * 0.25,
            width: MediaQuery.of(context).size.width * 0.31,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: new DecorationImage(
                  image: new AssetImage(imagePath),
                  colorFilter: new ColorFilter.mode(
                      color.withOpacity(0.6), BlendMode.darken),
                  fit: BoxFit.cover),
            ),
            child: new SizedBox.expand(
              child: Center(
                child: new Text(
                  categoryName,
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
