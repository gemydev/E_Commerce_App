import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/database/db_helper.dart';
import 'package:E_commerce/models/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/widgets/button.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CreditCard creditCard = CreditCard();
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                      "Payment method",
                      style: TextStyle(
                          color: LIGHT_BLACK, fontSize: 28, letterSpacing: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(90)),
        body: Form(
          key: _formKey,
          child: Center(child: InfoWidget(
            returnedWidget: (context, deviceInfo) {
              bool portrait = deviceInfo.orientation == Orientation.portrait;
              if (portrait) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        textFieldPaymentMethod(
                            Icons.credit_card,
                            "Credit Card Number",
                            "enter credit number", onSavedFun: (value) {
                          creditCard.cardNumber = value;
                        }),
                        textFieldPaymentMethod(
                            Icons.timer_off,
                            "Expiration Date",
                            "enter Expiration Date", onSavedFun: (value) {
                          creditCard.expirationDate = value;
                        }),
                        textFieldPaymentMethod(
                            Icons.confirmation_number,
                            "CVV / CVC",
                            "enter CVV / CVC", onSavedFun: (value) {
                          creditCard.ccv = value;
                        }),
                      ],
                    ),
                    CustomButton(
                      width: 300,
                      buttonName: "Add Card",
                      fontSize: 20,
                      onTapFun: () {

                      },
                    )
                  ],
                );
              } else {
                return ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        textFieldPaymentMethod(
                            Icons.credit_card,
                            "Credit Card Number",
                            "enter credit number", onSavedFun: (value) {
                          creditCard.cardNumber = value;
                        }),
                        textFieldPaymentMethod(
                            Icons.timer_off,
                            "Expiration Date",
                            "enter Expiration Date", onSavedFun: (value) {
                          creditCard.expirationDate = value;
                        }),
                        textFieldPaymentMethod(
                            Icons.confirmation_number,
                            "CVV / CVC",
                            "enter CVV / CVC", onSavedFun: (value) {
                          creditCard.ccv = value;
                        }),
                      ],
                    ),
                    CustomButton(
                      buttonName: "Add Card",
                      fontSize: 20,
                      onTapFun: onTapAddCard(),
                    )
                  ],
                );
              }
            },
          )),
        ));
  }

  Widget textFieldPaymentMethod(icon, title, errorMessage, {onSavedFun}) {
    return InfoWidget(
      returnedWidget: (context, deviceInfo) {
        return Container(
          height: deviceInfo.orientation == Orientation.portrait
              ? deviceInfo.screenHeight * 0.15
              : deviceInfo.screenHeight * 0.25,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(icon),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  child: TextFormField(
                    onSaved: onSavedFun,
                    validator: (value) {
                      if (value.isEmpty) {
                        return errorMessage;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: title,
                        labelStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  onTapAddCard(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _databaseHelper.insertCard(creditCard);
    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Please enter all data")));
    }
  }
}
