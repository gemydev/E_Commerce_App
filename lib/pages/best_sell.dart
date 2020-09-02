import 'package:E_commerce/constants/colors.dart';
import 'package:E_commerce/functions/functions.dart';
import 'package:E_commerce/widgets/gridViewOfPages.dart';
import 'package:flutter/material.dart';

class BestSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: Column(
              children: <Widget>[
                normalAppBar(context),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Best Sell",
                        style: TextStyle(color: LIGHT_BLACK, fontSize: 25),
                      ),
                    ))
              ],
            ),
            preferredSize: Size.fromHeight(100)),
        body: BodyOfPages());
  }
}
