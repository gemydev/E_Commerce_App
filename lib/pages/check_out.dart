import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/functions.dart';
import 'package:E_commerce/models/models.dart';
import 'package:E_commerce/pages/confirmation.dart';
import 'package:E_commerce/providers/providers.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  final Address address ;

  Checkout(this.address);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Product> cartProducts = Provider.of<CartDate>(context).products;
    var orderedProvider = Provider.of<OrderedData>(context);
    return Scaffold(
        key: _scaffoldKey,
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
                      "Checkout",
                      style: TextStyle(
                          color: LIGHT_BLACK, fontSize: 28, letterSpacing: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(95)),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: InfoWidget(
            returnedWidget: (context , deviceInfo){
              bool portrait = deviceInfo.orientation == Orientation.portrait;
              if(portrait){
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.47,
                          child: ListOfCards(list: cartProducts,)
                      ),
                    ),
                    finalInfo(widget.address, context),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: CustomButton(
                          width: MediaQuery.of(context).size.width*0.8,
                          fontSize: 21,
                          buttonName: "Buy",
                          onTapFun: () {
                            shiftByReplacement(context, Confirmation());
                            orderedProvider.addToOrderedList(cartProducts);
                            cartProducts.clear();
                          }),
                    ),
                  ],
                );
              }else{
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.55,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30 , right: 30),
                            child: ListOfCards(list: cartProducts,),
                          )
                      ),
                    ),
                    finalInfo(widget.address, context),
                    CustomButton(
                        fontSize: 21,
                        buttonName: "Buy",
                        onTapFun: () {
                          shiftByReplacement(context, Confirmation());
                          orderedProvider.addToOrderedList(cartProducts);
                          cartProducts.clear();
                        }),
                  ],
                );
              }
            },
          )
        ),

      );
  }
}
