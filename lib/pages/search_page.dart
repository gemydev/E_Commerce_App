import 'package:E_commerce/constants/field_name_firestore.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/pages/item_details.dart';
import 'package:E_commerce/services/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/SimpleSearch';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchEditController = TextEditingController();
  final FireStore _fireStore = FireStore();

  //==============================================
  //  Define widget for clear search bar data
  //==============================================
  IconButton _clearButton;

  //==========================================
  //  generate list of 200 items for search
  //==========================================
  final _listItems = List<String>.generate(200, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(_listItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20 , bottom: 20),
                child: Hero(
                  tag: "searchTag",
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.9,
                      height:  MediaQuery.of(context).size.height*.06,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          filter(value);
                        },
                        controller: searchEditController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          suffixIcon: _clearButton,
                          hintText: "Type To Search....",
                          hintStyle: TextStyle(color: Colors.black),
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
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
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: products.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only( left: 16 , bottom: 10),
                              child: GestureDetector(
                                onTap: () {normalShift(context, ItemDetail(
                                  product: products[index],
                                ));},
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.15,
                                      height: MediaQuery.of(context).size.height*0.06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "${products[index].imagePath}",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("${products[index].name}"),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("\$${products[index].price}"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: Text("Loading....."));
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
  
  void filter(String query) {
    List<String> mockList = List<String>();
    mockList.addAll(_listItems);
    if (query.isNotEmpty) {
      List<String> tempListData = List<String>();
      mockList.forEach((item) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          tempListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(tempListData);
        _clearButton = IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            searchEditController.clear();
            _clearButton = null;
            setState(() {
              items.clear();
              items.addAll(_listItems);
            });
          },
        );
      });

      return;
    } else {
      setState(() {
        _clearButton = null;
        items.clear();
        items.addAll(_listItems);
      });
    }
  }
}