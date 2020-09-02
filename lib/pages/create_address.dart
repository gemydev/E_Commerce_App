import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/database/db_helper.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/models/address.dart';
import 'package:E_commerce/pages/address_page.dart';
import 'package:E_commerce/services/infoForResponsiveUi/info_widget.dart';
import 'package:E_commerce/shared_prefs/prefs_functions.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAddress extends StatefulWidget {
  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _addressLane, _city, _postalCode;
  DatabaseHelper _databaseHelper = DatabaseHelper();
  Address address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: DARK_BLACK.withOpacity(0.7),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        iconTheme: IconThemeData(
          color: DARK_BLACK.withOpacity(0.7),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: InfoWidget(
              returnedWidget: (context, deviceInfo) {
                if (deviceInfo.orientation == Orientation.portrait) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Create Address",
                          style: TextStyle(
                              color: DARK_BLACK,
                              fontSize: 30,
                              letterSpacing: 1.5),
                        ),
                      ),
                    Container(
                      height: deviceInfo.screenHeight*0.7,
                      child: ListView(
                        children: <Widget>[
                          _infoField(
                              title: "Address lane",
                              onSavedFun: (value) {
                                _addressLane = value;
                              }),
                          _infoField(
                              title: "City",
                              onSavedFun: (value) {
                                _city = value;
                              }),
                          _infoField(
                              title: "Postal Code",
                              onSavedFun: (value) {
                                _postalCode = value;
                              }),
                          _infoField(
                              title: "Phone Number",
                              onSavedFun: (value) {
                                SharedFunctions().storePhoneNumber(value);
                              }),
                        ],
                      ),
                    ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                            width: MediaQuery.of(context).size.width * 0.8,
                            fontSize: 20,
                            buttonName: "Add Address",
                            onTapFun: () {_onTapFun();}),
                      ),
                    ],
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Create Address",
                          style: TextStyle(
                              color: DARK_BLACK,
                              fontSize: 30,
                              letterSpacing: 1.5),
                        ),
                      ),
                      _infoField(
                          title: "Address lane",
                          onSavedFun: (value) {
                            _addressLane = value;
                          }),
                      _infoField(
                          title: "City",
                          onSavedFun: (value) {
                            _city = value;
                          }),
                      _infoField(
                          title: "Postal Code",
                          onSavedFun: (value) {
                            _postalCode = value;
                          }),
                      _infoField(
                          title: "Phone Number",
                          onSavedFun: (value) {
                            SharedFunctions().storePhoneNumber(value);
                          }),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                              width: MediaQuery.of(context).size.width * 0.8,
                              fontSize: 20,
                              buttonName: "Add Address",
                              onTapFun: () {_onTapFun();}),
                        ),
                      ),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }

  Widget _infoField({String title, Function onSavedFun}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "please enter $title";
          } else {
            return null;
          }
        },
        onSaved: onSavedFun,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: title,
          labelStyle: TextStyle(fontSize: 18),
          hintStyle: TextStyle(color: DARK_BLACK.withOpacity(0.9)),
        ),
      ),
    );
  }

  _onTapFun() async {
    _formKey.currentState.save();
    _databaseHelper.insertAddress(Address(
        addressLane: _addressLane, postalCode: _postalCode, city: _city));
    shiftByReplacement(context, AddressPage());
  }



}
