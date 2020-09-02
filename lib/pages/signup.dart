
import 'package:E_commerce/constants/constants.dart';
import 'package:E_commerce/functions/functions.dart';
import 'package:E_commerce/models/customer.dart';
import 'package:E_commerce/pages/login.dart';
import 'package:E_commerce/providers/modal_hud.dart';
import 'package:E_commerce/services/auth.dart';
import 'package:E_commerce/services/cloud_firestore.dart';
import 'package:E_commerce/shared_prefs/prefs_functions.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:E_commerce/widgets/text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _name, _email, _password;
  Auth _auth = Auth();
  FireStore _fireStore = FireStore();
  final _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModalProgress>(context).callValue,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15, right: 12, left: 20),
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                Text("SignUp", style: TITLE_STYLE),
                SizedBox(
                  height: 60,
                ),
                TextFieldClass(
                  onSavedFun: (value) {
                    _name = value;
                  },
                  hintText: "",
                  labelText: "Name",
                  prefixIcon: Icons.person,
                  validateHint: "Please enter your name",
                ),
                SizedBox(
                  height: 25,
                ),
                TextFieldClass(
                  onSavedFun: (value) {
                    _email = value;
                  },
                  hintText: "email@address.com",
                  labelText: "Email",
                  prefixIcon: Icons.email,
                  validateHint: "Please enter your email",
                ),
                SizedBox(
                  height: 25,
                ),
                TextFieldClass(
                  onSavedFun: (value) {
                    _password = value;
                  },
                  hintText: "Password",
                  labelText: "Password",
                  prefixIcon: Icons.vpn_key,
                  validateHint: "Please enter your password",
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26),
                  child: CustomButton(
                    fontSize: 14,
                    buttonName: "Sign Up",
                    onTapFun: _onTapFun,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        color: NOTE_COLOR,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        shiftByReplacement(context, Login());
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: DARK_BLACK,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapFun() async {
    try {
      if (_globalKey.currentState.validate()) {
        _globalKey.currentState.save();
        Provider.of<ModalProgress>(context, listen: false).inAsyncCallFun(true);
        var result = await _auth.signUp(
            email: _email.trim(), password: _password.trim());
        _fireStore.addCustomerInfo(
            Customer(
              name: _name,
            ),
            result.user.uid);
        Provider.of<ModalProgress>(context, listen: false)
            .inAsyncCallFun(false);
        SharedFunctions().storeEmail(_email);
        final snackBar = SnackBar(content: Text("Done successfully..."));
        _scaffoldKey.currentState.showSnackBar(snackBar);
        normalShift(context, Login());
      }
    } on PlatformException catch (e) {
      Provider.of<ModalProgress>(context, listen: false).inAsyncCallFun(true);
      Provider.of<ModalProgress>(context, listen: false).inAsyncCallFun(false);
      final snackBar = SnackBar(content: Text(e.message));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
