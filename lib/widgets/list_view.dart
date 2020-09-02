import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/providers/cart_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfCards extends StatefulWidget {
  final List list;

  ListOfCards({this.list});

  @override
  _ListOfCardsState createState() => _ListOfCardsState();
}

class _ListOfCardsState extends State<ListOfCards> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              elevation: 3.7,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width / 4,
                          child: Image.asset(
                            "${widget.list[index].imagePath}",
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(widget.list[index].name),
                          Text(
                            widget.list[index].shopName,
                            style: TextStyle(
                              color: LIGHT_BLACK,
                            ),
                          ),
                          Text(
                            "\$${((double.parse(widget.list[index].price)) * (widget.list[index].quantity)).toString()}",
                            style: TextStyle(
                              color: GRADIENT_BEGIN,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  if (widget.list[index].quantity > 1) {
                                    setState(() {
                                      widget.list[index].quantity--;
                                    });
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  width: 35,
                                  child: Icon(
                                    Icons.remove,
                                    color: DARK_BLACK.withOpacity(0.5),
                                  ),
                                  color: LIGHT_BLACK.withOpacity(0.3),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 35,
                                child: Center(
                                    child: Text(widget.list[index].quantity
                                        .toString())),
                                color: LIGHT_BLACK.withOpacity(0.3),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.list[index].quantity++;
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 35,
                                  child: Icon(
                                    Icons.add,
                                    color: DARK_BLACK.withOpacity(0.5),
                                  ),
                                  color: LIGHT_BLACK.withOpacity(0.3),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                Provider.of<CartDate>(context, listen: false)
                                    .removeProduct(widget.list[index]);
                              },
                              child: Icon(Icons.clear)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
