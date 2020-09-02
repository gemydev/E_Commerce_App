import 'package:E_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

class VisaCard extends StatelessWidget {
  String visaNumber = "1234567891234567".substring(0, 4) +
      "   " +
      "1234567891234567".substring(4, 8) +
      "   " +
      "1234567891234567".substring(8, 12) +
      "   " +
      "1234567891234567".substring(12, 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xff003776),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 15,
                  right: 15,
                  child: Image.asset(
                    "assets/images/visa_PNG30.png",
                    height: 40,
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 15,
                  child: Text(
                    visaNumber,
                    style:
                        TextStyle(color: WHITE.withOpacity(0.8), fontSize: 25),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
