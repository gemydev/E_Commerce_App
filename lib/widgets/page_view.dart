
import 'package:flutter/material.dart';

class PageViewPage extends StatelessWidget {
  static PageController pageController = PageController(initialPage: 2 );
  final PageView pageView = PageView(
    allowImplicitScrolling: false,
    controller: pageController ,
    children: <Widget>[page1(),page2(),page3()],
    scrollDirection: Axis.horizontal,
    pageSnapping: true,
    reverse: true,
  );
  @override
  Widget build(BuildContext context) {
    return pageView;
  }
}

Widget page1(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Image.asset("assets/images/VisaCreditCard.png" ,
    width: 50,
    ),
  );
}

Widget page2(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Image.asset("assets/images/VisaCreditCard.png",
      width: 50,),
  );
}

Widget page3(){
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Image.asset("assets/images/VisaCreditCard.png",
      ),
  );
}
