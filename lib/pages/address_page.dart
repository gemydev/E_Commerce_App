import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/database/db_helper.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/address.dart';
import 'package:E_commerce/pages/create_address.dart';
import 'package:E_commerce/pages/payment.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/shared_prefs/prefs_keys.dart';
import 'package:E_commerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextStyle _normalStyle = TextStyle(
    fontSize: 20,
  );
  DatabaseHelper _databaseHelper = DatabaseHelper();
  int selectedIndex;
  List<Address> addressList = [];
  String _phoneNumber ;

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _phoneNumber = (sharedPreferences.getString(PHONE_NUMBER_KEY) ?? '');
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Address chosenAddress;

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
                    "Address",
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
              return ListView(
                children: <Widget>[
                  Container(
                      height: portrait
                          ? deviceInfo.screenHeight * 0.65
                          : deviceInfo.screenHeight * 0.45,
                      child: FutureBuilder<List<Address>>(
                          future: _databaseHelper.getAddressesList(),
                          builder:
                              (context, AsyncSnapshot<List<Address>> snapshot) {
                            addressList = snapshot.data;
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                                      child: Container(
                                          height: portrait
                                              ? deviceInfo.screenHeight * 0.18
                                              : deviceInfo.screenHeight * 0.25,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      snapshot.data[index]
                                                          .addressLane
                                                          .toString(),
                                                      style: _normalStyle,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      snapshot.data[index].city
                                                          .toString(),
                                                      style: _normalStyle,
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                          .postalCode
                                                          .toString(),
                                                      style: _normalStyle,
                                                    ),
                                                    Text(
                                                      _phoneNumber.toString(),
                                                      style: _normalStyle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print(index.toString());
                                                  setState(() {
                                                    chosenAddress = snapshot.data[index];
                                                    selectedIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: selectedIndex ==
                                                            index
                                                        ? Icon(
                                                            Icons.check_box,
                                                            color: Colors.blue,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                          )),
                                              )
                                            ],
                                          )),
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text("Loading..."),
                              );
                            }
                          })),
                  Container(
                    height: portrait
                        ? deviceInfo.screenHeight -(screenHeight*0.65 + 90 + statusBarHeight)
                        : deviceInfo.screenHeight * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        dashedButton(context, CreateAddress(), "Add Address"),
                        CustomButton(
                            width: portrait
                                ? screenWidth * 0.85
                                : screenWidth * 0.65,
                            fontSize: 20,
                            buttonName: "Continue To Payment",
                            onTapFun: () {_onContinueTap();}),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
  _onContinueTap(){
    if (addressList.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please Add Address"),
      duration: Duration(seconds: 2),
      ));
    } else if (chosenAddress == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please Choose Address")));
    } else {
      normalShift(
          context,
          PaymentPage(
            address: chosenAddress,
          ));
    }
  }
}
