import 'package:E_commerce/constants/field_name_firestore.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/pages/item_details.dart';
import 'package:E_commerce/services/cloud_firestore.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {
  final FireStore _fireStore = FireStore();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: InfoWidget(
            returnedWidget: (context, deviceInfo) {
              return Container(
                height: deviceInfo.orientation == Orientation.portrait
                    ? deviceInfo.screenHeight * 0.38
                    : deviceInfo.screenHeight * 0.7,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _fireStore.loadDataOfProducts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        List<Product> products = [];
                        if (snapshot.hasData) {
                          for (var doc in snapshot.data.documents) {
                            products.add(Product(
                                name: doc.data[kProductName],
                                description: doc.data[kProductDescription],
                                shopName: doc.data[kProductShopName],
                                price: doc.data[kProductPrice],
                                oldPrice: doc.data[kProductOldPrice],
                                imagePath: doc.data[kProductImagePath]));
                          }
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 10, bottom: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: products.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        normalShift(
                                            context,
                                            ItemDetail(
                                              product: products[index],
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                              child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "${products[index].imagePath}",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 2,
                                                left: 2,
                                                top: 5,
                                                bottom: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                    "\$${products[index].price}"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text("${products[index].name}"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
