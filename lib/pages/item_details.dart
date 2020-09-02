import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/app_bar_functions.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/pages/address_page.dart';
import 'package:E_commerce/providers/cart_data.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class ItemDetail extends StatefulWidget {
  final Product product;

  ItemDetail({@required this.product});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  List<Color> colors = [
    Colors.green,
    Colors.orange,
    Colors.brown,
    Colors.blue,
    Colors.red
  ];
  bool sizeSelected = true;
  bool colorSelected = false;
  String selectedSize;
  Color selectedColor;
  TextStyle selectedTextStyleInSizes =
      TextStyle(fontSize: 21, fontWeight: FontWeight.w500, color: Colors.white);
  TextStyle selectedTextStyle =
      TextStyle(fontSize: 21, fontWeight: FontWeight.w500);
  TextStyle normalTextStyle = TextStyle(fontSize: 18);

  @override
  void initState() {
   // bool sizeSelected = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartData = Provider.of<CartDate>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          child: CustomAppBar(
            product: widget.product,
          ),
          preferredSize: Size.fromHeight(56)),
      body: InfoWidget(
        returnedWidget: (context, deviceInfo) {
          bool portrait = deviceInfo.orientation == Orientation.portrait;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: portrait
                      ? deviceInfo.screenHeight * 0.25
                      : deviceInfo.screenHeight * 0.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.product.imagePath),
                          fit: BoxFit.fitHeight)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.product.name,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "\$${widget.product.price}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: GRADIENT_BEGIN),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          widget.product.oldPrice == null ||
                                  widget.product.oldPrice == " "
                              ? Text(
                                  " ",
                                )
                              : Text(
                                  "\$${widget.product.oldPrice}",
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: GRADIENT_BEGIN,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: portrait
                                ? deviceInfo.screenHeight * 0.055
                                : deviceInfo.screenHeight * 0.1,
                            width: portrait
                                ? deviceInfo.screenWidth * 0.15
                                : deviceInfo.screenWidth * 0.09,
                            decoration: BoxDecoration(
                                color: GRADIENT_BEGIN,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "4.5",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Very Good",
                            style: TextStyle(
                              color: DARK_BLACK,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "49 Reviews",
                          style: TextStyle(
                              color: GRADIENT_BEGIN,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: GRADIENT_BEGIN,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 11),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: ReadMoreText(
                          widget.product.description,
                          trimLines: 2,
                          colorClickableText: GRADIENT_BEGIN,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: ' ...Show more',
                          trimExpandedText: ' show less',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: GRADIENT_BEGIN,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          "Select Size",
                          style: sizeSelected
                              ? selectedTextStyle
                              : normalTextStyle,
                        ),
                        onTap: () {
                          setState(() {
                            sizeSelected = true;
                            colorSelected = false;
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            sizeSelected = false;
                            colorSelected = true;
                          });
                        },
                        child: Text("Select Color",
                            style: colorSelected
                                ? selectedTextStyle
                                : normalTextStyle),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: GRADIENT_BEGIN,
                ),
                listOfSizeOrColor(context, sizes, colors),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {
                            onTapAddToCart(context, widget.product);
                          },
                          color: LIGHT_BLACK.withOpacity(0.6),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              "ADD TO CART",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )),
                      FlatButton(
                          color: GRADIENT_BEGIN,
                          onPressed: () {
                            cartData.products.add(widget.product);
                            normalShift(context, AddressPage());
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              "BUY NOW",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onTapAddToCart(context, Product product) {
    CartDate cartData = Provider.of<CartDate>(context, listen: false);
    List<Product> productsInCart = cartData.products;
    bool foundIt = false;
    for (var item in productsInCart) {
      if (item.name == product.name &&
          item.price == product.price &&
          item.description == product.description) {
        foundIt = true;
      }
    }
    if (foundIt) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("this is added before.."),
        duration: Duration(seconds: 1),
      ));
    } else {
      cartData.addProduct(product);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Done..."),
        duration: Duration(seconds: 1),
      ));
    }
  }

  Widget listOfSizeOrColor(BuildContext context, List sizes, List colors) {
    return Padding(
        padding: const EdgeInsets.only(top: 22, bottom: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 47,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: sizes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (sizeSelected) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.product.size = sizes[index];
                          selectedSize = sizes[index];
                        });
                      },
                      child: Card(
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                              color: selectedSize == sizes[index]
                                  ? GRADIENT_BEGIN
                                  : LIGHT_BLACK.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              sizes[index],
                              style: selectedSize == sizes[index]
                                  ? selectedTextStyleInSizes
                                  : TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        elevation: 2,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    );
                  } else if (colorSelected) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = colors[index];
                        });
                      },
                      child: Card(
                        child: Container(
                          width: selectedColor == colors[index] ? 71 : 60,
                          decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        elevation: selectedColor == colors[index] ? 20 : 0,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.transparent)),
                      ),
                    );
                  } else
                    return null;
                }),
          ),
        ));
  }
}
