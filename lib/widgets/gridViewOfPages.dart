import 'package:E_commerce/constants/field_name_firestore.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/item_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyOfPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(kProductCollectionName).snapshots(),
        builder: (BuildContext context , AsyncSnapshot snapshot){
          List<Product> products =[];
          if (snapshot.hasData){
            for (var doc in snapshot.data.documents){
              products.add(Product(
                name: doc.data[kProductName],
                  description: doc.data[kProductDescription],
                  shopName: doc.data[kProductShopName],
                  price: doc.data[kProductPrice],
                  oldPrice: doc.data[kProductOldPrice],
                  imagePath: doc.data[kProductImagePath]
              ));
            }
            return GridView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 16 , childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      normalShift(context, ItemDetail(product: products[index]));
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
                });
          }else{
            return Center(child: Text("Loading..."));
          }
        },
      )
    );
  }
}
