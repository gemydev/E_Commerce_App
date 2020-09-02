import 'package:E_commerce/adminPanel/admin_home.dart';
import 'package:E_commerce/constants/constants.dart';
import 'package:E_commerce/functions/functions.dart';
import 'package:E_commerce/pages/home.dart';
import 'package:E_commerce/pages/signup.dart';
import 'package:E_commerce/providers/providers.dart';
import 'package:E_commerce/shared_prefs/prefs_functions.dart';
import 'package:E_commerce/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userId;
  String _email, _password ;
  bool keepMeLoggedIn = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                Text("Login", style: TITLE_STYLE),
                SizedBox(
                  height: 60,
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
                Padding(
                  padding: const EdgeInsets.only(top: 20 ,bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        checkColor: GRADIENT_BEGIN,
                        activeColor: Colors.transparent,
                          value: keepMeLoggedIn,
                          onChanged: (value){
                            setState(() {
                              keepMeLoggedIn = value ;
                            });
                          }
                      ),
                      Text("Remember me")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26 ,right: 26 , bottom: 15),
                  child: CustomButton(
                    fontSize: 14,
                    buttonName: "Login",
                    onTapFun: _onTapFun,
                  ),
                ),
                signInButton(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account ?",
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
                        normalShift(context, SignUp());
                      },
                      child: Text(
                        "Sign Up",
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
    final modalHud = Provider.of<ModalProgress>(context , listen: false);
    if (keepMeLoggedIn == true){
      SharedFunctions().storeLoggedInState(keepMeLoggedIn);
    }
    try {
      if (_globalKey.currentState.validate()) {
        modalHud.inAsyncCallFun(true);
        _globalKey.currentState.save();
        AuthResult newUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email.trim(), password: _password.trim());
        SharedFunctions().storeEmail(_email);
        modalHud.inAsyncCallFun(false);
        if(_email == "mohamedgemy1211@gmail.com" && _password == "121199"){
          shiftByReplacement(context, AdminHome());
        }else{
          shiftByReplacement(context, Home());
        }

      }
    } on PlatformException catch (e) {
      modalHud.inAsyncCallFun(false);
      final snackBar = SnackBar(content: new Text(e.message) , );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

}



