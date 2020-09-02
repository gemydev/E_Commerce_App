import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/functions.dart';
import 'package:E_commerce/pages/home.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(125),
                  color: Colors.black.withOpacity(0.05),
                ),
                child: Center(
                  child: Container(
                    height: 135,
                    width: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black.withOpacity(0.06),
                    ),
                    child: Image.asset(
                      "assets/images/like.png",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35,bottom: 10),
                child: Text(
                  "Confirmation",
                  style: TextStyle(fontSize: 31, color: DARK_BLACK.withOpacity(0.8)),
                ),
              ),
              Text(
                "You have successfully \n completed your payment procedure",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50,),
              CustomButton(
                  fontSize: 20,
                  buttonName: "Back to Home", onTapFun: (){
                shiftByReplacement(context,Home());
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
