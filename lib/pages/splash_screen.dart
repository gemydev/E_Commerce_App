import 'dart:async';
import 'package:E_commerce/constants/gradient.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/1st_Screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, shiftByReplacement(context, FirstScreen()));
  }

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => FirstScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: gradientFunIntro(),
          ),
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.42,
            decoration: BoxDecoration(
              gradient: gradientFunIntroCircle(),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.21,
            decoration: BoxDecoration(
              gradient: gradientFunIntroCircle(),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            "assets/images/icon.png",
            height: 80,
          ),
        )
      ],
    );
  }
}
