import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/final_info.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/address.dart';
import 'package:E_commerce/pages/check_out.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:E_commerce/widgets/dashed_button.dart';
import 'package:E_commerce/widgets/page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'payment_method.dart';

class PaymentPage extends StatefulWidget {
  final Address address;

  PaymentPage({this.address});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

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
                    "Payment",
                    style: TextStyle(
                        color: LIGHT_BLACK, fontSize: 28, letterSpacing: 1.5),
                  ),
                ),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(90)),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: InfoWidget(
            returnedWidget: (context, deviceInfo) {
              bool portrait = deviceInfo.orientation == Orientation.portrait;
              if (portrait) {
                return ListView(
                  children: <Widget>[
                    Container(
                        height: screenHeight * 0.3, child: PageViewPage()),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                          height: screenHeight -
                              (90 +
                                  statusBarHeight +
                                  (screenHeight * 0.2) +
                                  (screenHeight * 0.3)),
                          child: Center(
                              child: finalInfo(widget.address, context))),
                    ),
                    Container(
                      height: screenHeight * 0.2,
                      child: Column(
                        children: <Widget>[
                          dashedButton(context, PaymentMethod(), "Add Card"),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              width: screenWidth * 0.85,
                              fontSize: 20,
                              buttonName: "Checkout",
                              onTapFun: () {
                                normalShift(context, Checkout(widget.address));
                              }),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return ListView(
                  children: <Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: PageViewPage()),
                    finalInfo(widget.address, context),
                    Column(
                      children: <Widget>[
                        dashedButton(context, PaymentMethod(), "Add Card"),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                            width: deviceInfo.screenWidth * 0.65,
                            fontSize: 20,
                            buttonName: "Checkout",
                            onTapFun: () {
                              normalShift(context, Checkout(widget.address));
                            }),
                      ],
                    )
                  ],
                );
              }
            },
          )),
    );
  }
}
