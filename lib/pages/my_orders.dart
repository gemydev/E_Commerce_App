import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/providers/cart_data.dart';
import 'package:E_commerce/providers/ordered_provider.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {

  @override
  Widget build(BuildContext context) {
    var orderedProducts = Provider.of<OrderedData>(context).orderedProducts;
    var cartProvider = Provider.of<CartDate>(context);
    return Scaffold(
      appBar: PreferredSize(
          child: Column(
            children: <Widget>[
              AppBar(
                iconTheme: IconThemeData(color: DARK_BLACK.withOpacity(0.7)),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "My Orders",
                    style: TextStyle(
                        color: LIGHT_BLACK, fontSize: 25, letterSpacing: 1.5),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(100)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: ListView.builder(
            itemCount: orderedProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.19,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(
                                orderedProducts[index].imagePath,
                                ),
                                fit: BoxFit.cover
                              ),
                                borderRadius: BorderRadius.circular(5)),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width / 4,
                            ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(orderedProducts[index].name),
                            Text(
                              orderedProducts[index].shopName,
                              style: TextStyle(
                                color: LIGHT_BLACK,
                              ),
                            ),
                            Text(
                              "\$${orderedProducts[index].price}",
                              style: TextStyle(
                                color: GRADIENT_BEGIN,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InfoWidget(
                              returnedWidget: (context , deviceInfo){
                                return CustomButton(
                                  width: deviceInfo.screenWidth*0.25,
                                  height: deviceInfo.screenHeight*0.05,
                                  fontSize: 14,
                                  buttonName: "Order Again",
                                  onTapFun: () {
                                    cartProvider.addProduct(orderedProducts[index]);
                                  },
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
