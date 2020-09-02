import 'package:E_commerce/adminPanel/edit_product.dart';
import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/constants/field_name_firestore.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/widgets/customPopupMenuItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:E_commerce/services/cloud_firestore.dart';

class ManageProductPage extends StatelessWidget {
  final FireStore _fireStore = FireStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: LIGHT_BLACK),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.loadDataOfProducts(),
        builder: (context, snapshot) {
          List<Product> products = [];
          if (snapshot.hasData) {
            for (var doc in snapshot.data.documents) {
              products.add(Product(
                  id: doc.documentID,
                  name: doc.data[kProductName],
                  description: doc.data[kProductDescription],
                  shopName: doc.data[kProductShopName],
                  price: doc.data[kProductPrice],
                  oldPrice: doc.data[kProductOldPrice],
                  imagePath: doc.data[kProductImagePath]));
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.height - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              CustomPopupMenuItem(
                                child: Text("Edit"),
                                function: () {
                                  Navigator.pop(context);
                                  normalShift(
                                      context,
                                      EditProductPage(
                                        product: products[index],
                                      ));
                                },
                              ),
                              CustomPopupMenuItem(
                                child: Text("Delete"),
                                function: () {
                                  _fireStore.deleteProduct(
                                      docId: products[index].id);
                                  Navigator.pop(context);
                                },
                              )
                            ]);
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
                                      "${products[index].imagePath}",
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 2, left: 2, top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("\$${products[index].price}"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("${products[index].name}"),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return Center(child: Text("Loading....."));
          }
        },
      ),
    );
  }
}
