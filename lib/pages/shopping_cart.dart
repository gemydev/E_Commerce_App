import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/models/product.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/address_page.dart';
import 'package:E_commerce/providers/cart_data.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var heightOfStateBar = MediaQuery.of(context).padding.top;
    List<Product> cartProducts = Provider.of<CartDate>(context).products;
    if(cartProducts.isEmpty){
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
                      "Cart",
                      style: TextStyle(
                          color: LIGHT_BLACK, fontSize: 25, letterSpacing: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(90)),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Center(child: Text("Cart is empty..." , style: TextStyle(
            fontSize: 20 , color:LIGHT_BLACK
          ),),),
        ),
      );
    }else{
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
                      "Cart",
                      style: TextStyle(
                          color: LIGHT_BLACK, fontSize: 25, letterSpacing: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(90)),
        body: SingleChildScrollView(
          child: InfoWidget(
            returnedWidget: (context , deviceInfo){
              bool portrait = deviceInfo.orientation == Orientation.portrait;
              var screenHeight = deviceInfo.screenHeight;
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Container(
                        height: portrait ? (screenHeight-(heightOfStateBar+90))-(screenHeight*0.1) :
                        (screenHeight-(heightOfStateBar+90))-(screenHeight*0.17)
                        ,
                        child: ListOfCards(list: cartProducts,)),
                  ),
                  CustomButton(
                      width: MediaQuery.of(context).size.width*0.7,
                      height: portrait ? screenHeight*0.07 : screenHeight*0.11,
                      fontSize: 20,
                      buttonName: "Continue",
                      onTapFun: () {
                        normalShift(context, AddressPage());
                      }),
                ],
              );
            },
          )
        ),


      );
    }
  }

}
