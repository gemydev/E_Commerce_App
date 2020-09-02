import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/maps.dart';
import 'package:E_commerce/providers/settings_provider.dart';
import 'package:E_commerce/services/auth.dart';
import 'package:E_commerce/shared_prefs/prefs_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Auth _auth = Auth();
  String _firstName = ' ',
      _lastName = ' ',
      _gender = ' ',
      _phoneNumber = ' ',
      _email,
      _addressLane,
      _city;
  TextEditingController controllerFirstName,
      controllerLastName,
      controllerCity,
      controllerLane = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _firstName = sharedPreferences.getString(FIRST_NAME_KEY);
      _lastName = sharedPreferences.getString(LAST_NAME_KEY);
      _gender = sharedPreferences.getString(GENDER_KEY);
      _phoneNumber = sharedPreferences.getString(PHONE_NUMBER_KEY);
      _email = sharedPreferences.getString(EMAIL_KEY);
      _addressLane = sharedPreferences.getString(ADDRESS_LANE_KEY);
      _city = sharedPreferences.getString(CITY_KEY);
    });
  }

  TextStyle _headerStyle = TextStyle(
      color: DARK_BLACK.withOpacity(0.6),
      fontSize: 18,
      fontWeight: FontWeight.w500);
  TextStyle _itemStyle = TextStyle(
      color: DARK_BLACK.withOpacity(0.9),
      fontSize: 16,
      fontWeight: FontWeight.w500);
  TextStyle _infoStyle = TextStyle(
      color: DARK_BLACK.withOpacity(0.7),
      fontSize: 14,
      fontWeight: FontWeight.w500);
  TextStyle _saveStyle = TextStyle(
      color: GRADIENT_BEGIN, fontSize: 17, fontWeight: FontWeight.w500);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: DARK_BLACK,
                    )),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                          color: LIGHT_BLACK, fontSize: 28, letterSpacing: 1.5),
                    ),
                  ))
            ],
          ),
          preferredSize: Size.fromHeight(90)),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
        child: ListView(
          children: <Widget>[
            Text(
              "Your Account".toUpperCase(),
              style: _headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  accountFun(
                      headTitle: "Full Name",
                      info: _firstName != null && _lastName != null
                          ? "$_firstName $_lastName"
                          : " ",
                      onTapFun: () {
                        _showDialog(
                            windowName: "Full Name",
                            field1: "First Name",
                            field2: "LastName",
                            initValue1: _firstName,
                            initValue2: _lastName,
                            onTapSave: () {});
                      }),
                  Divider(
                    color: Colors.transparent,
                  ),
                  accountFun(
                      headTitle: "Password",
                      info: "******",
                      onTapFun: () {
                        _showDialog(
                            windowName: "Password",
                            field1: "Current Password",
                            field2: "New Password",
                            onTapSave: () {});
                      }),
                  Divider(
                    color: Colors.transparent,
                  ),
                  accountFun(headTitle: "Email", info: _email ?? " "),
                  Divider(
                    color: Colors.transparent,
                  ),
                  accountFun(
                      headTitle: "Address",
                      info: _addressLane == null && _city == null
                          ? " "
                          : "$_addressLane - $_city",
                      onTapFun: () {
                        _showDialog(
                            windowName: "Address",
                            field1: "Address Lane",
                            field2: "City",
                            onTapSave: () {});
                      }),
                  Divider(
                    color: Colors.transparent,
                  ),
                  accountFun(
                      headTitle: "Phone Number",
                      info: _phoneNumber != null ? "$_phoneNumber" : " ",
                      onTapFun: () {
                        _showDialog(
                            windowName: "Phone Number", field1: "Phone Number");
                      })
                ],
              ),
            ),
            Divider(
              color: GRADIENT_BEGIN,
            ),
            Text(
              "Languages".toUpperCase(),
              style: _headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "English",
                          style: _itemStyle,
                        ),
                        Switch(
                            value: settingsProvider.englishSelected,
                            onChanged: (value) {
                              setState(() {
                                settingsProvider.selectEnglish(value);
                              });
                            })
                      ],
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Arabic",
                          style: _itemStyle,
                        ),
                        Switch(
                            value: settingsProvider.arabicSelected,
                            onChanged: (value) {
                              setState(() {
                                settingsProvider.selectArabic(value);
                              });
                            })
                      ],
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
            Divider(
              color: GRADIENT_BEGIN,
            ),
            Text(
              "Location".toUpperCase(),
              style: _headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: GestureDetector(
                onTap: () {
                  onTapLocation();
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "location",
                        style: _itemStyle,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 10),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
            Divider(
              color: GRADIENT_BEGIN,
            ),
            Text(
              "Appearance".toUpperCase(),
              style: _headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Dark Mode",
                      style: _itemStyle,
                    ),
                    Switch(
                      onChanged: (value) {
                        setState(() {
                          settingsProvider.selectDark(value);
                        });
                      },
                      value: settingsProvider.darkModeSelected,
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 10),
                height: 40,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
              ),
            ),
            Divider(
              color: GRADIENT_BEGIN,
            ),
            Text(
              "more".toUpperCase(),
              style: _headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      connectWithUsFun();
                    },
                    child: Container(
                      child: Text(
                        "Connect with us",
                        style: _itemStyle,
                      ),
                      padding: EdgeInsets.only(left: 10),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Text(
                      "Rate our app",
                      style: _itemStyle,
                    ),
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    normalShift(
        context,
        LocationMap(
          latitude: position.latitude,
          longitude: position.longitude,
        ));
  }

  void _showDialog(
      {String windowName,
      field1,
      field2,
      initValue1 = "",
      initValue2 = "",
      Function onTapSave}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (windowName == "Phone Number") {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    Text(
                      windowName,
                      style: _headerStyle,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      field1,
                                      style: _itemStyle,
                                    ),
                                    TextFormField(
                                      initialValue: _phoneNumber,
                                      onSaved: (value) async {
                                        SharedPreferences sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.setString(
                                            PHONE_NUMBER_KEY, value);
                                      },
                                      decoration: InputDecoration(
                                        prefixText: "     ",
                                        border: InputBorder.none,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: FlatButton(
                          onPressed: () {
                            _formKey.currentState.save();
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Save",
                              style: _saveStyle,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          } else {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    Text(
                      windowName,
                      style: _headerStyle,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  field1,
                                  style: _itemStyle,
                                ),
                                TextFormField(
                                  initialValue: windowName == "Password"
                                      ? null
                                      : initValue1,
                                  decoration: InputDecoration(
                                    prefixText: "     ",
                                    border: InputBorder.none,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  field2,
                                  style: _itemStyle,
                                ),
                                TextFormField(
                                  initialValue: windowName == "Password"
                                      ? null
                                      : initValue2,
                                  obscureText:
                                      windowName == "Password" ? true : false,
                                  decoration: InputDecoration(
                                    prefixText: "     ",
                                    border: InputBorder.none,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: FlatButton(
                        onPressed: () {
                          onTapSave();
                        },
                        child: Text(
                          "Save",
                          style: _saveStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }

  void connectWithUsFun() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 15),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: <Widget>[
                  Text(
                    "Connect With Us",
                    style: _headerStyle,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          connectUsItem(
                              url:
                                  'https://www.facebook.com/profile.php?id=100005572029178',
                              path: 'assets/icons/facebook1.png',
                              name: "Facebook"),
                          connectUsItem(
                              url: 'mailto:mohamedgemy1211@gmail.com',
                              path: 'assets/icons/gmail.png',
                              name: "Gmail"),
                          connectUsItem(
                              url: 'https://github.com/gemydev',
                              path: 'assets/icons/github.png',
                              name: "Github"),
                          connectUsItem(
                              url:
                                  'https://www.linkedin.com/in/mohamed-gamal-4270a7176',
                              path: 'assets/icons/linkedin1.png',
                              name: "LinkedIn"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget accountFun({String headTitle, String info, Function onTapFun}) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                headTitle,
                style: _itemStyle,
              ),
              Text(
                info ?? " ",
                style: _infoStyle,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              onTapFun();
            },
            child: headTitle == "Email" ? Text("") : Icon(Icons.edit),
          )
        ],
      ),
      padding: EdgeInsets.only(left: 10),
      height: 40,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget connectUsItem({url, path, name}) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(path),
            radius: 20,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 18,
          ),
          Text(
            name,
            style: _itemStyle,
          )
        ],
      ),
    );
  }
}
