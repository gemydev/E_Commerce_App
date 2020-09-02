import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/login.dart';
import 'package:E_commerce/pages/signup.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to GemyStore",
              style: TextStyle(
                color: DARK_BLACK.withOpacity(0.7),
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              "Explore Us",
              style: TextStyle(
                color: DARK_BLACK.withOpacity(0.7),
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Image.asset("assets/images/intro.png"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 36),
              child: CustomButton(
                buttonName: "Login",
                onTapFun: () {
                  normalShift(context, Login());
                },
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                normalShift(context, SignUp());
              },
              child: Text(
                "SignUp",
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
