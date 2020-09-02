import 'package:E_commerce/adminPanel/add_product.dart';
import 'package:E_commerce/adminPanel/manage_product.dart';
import 'package:E_commerce/adminPanel/view_orders.dart';
import 'package:E_commerce/functions/navigation_funs.dart';
import 'package:E_commerce/pages/login.dart';
import 'package:E_commerce/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Container(), preferredSize: Size.fromHeight(100)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CustomButton(
              width: MediaQuery.of(context).size.width*.65,
              buttonName: "Add Product",
              fontSize: 20,
              onTapFun: () {
                normalShift(context, AddProductPage());
              },),
            SizedBox(height: 16,),
            CustomButton(
              width: MediaQuery.of(context).size.width*.65,
              buttonName: "Manage Product",
              fontSize: 20,
              onTapFun: () {
                normalShift(context, ManageProductPage());
              },),
            SizedBox(height: 16,),
            CustomButton(
              width: MediaQuery.of(context).size.width*.65,
              buttonName: "View Orders",
              fontSize: 20,
              onTapFun: () {
                normalShift(context, ViewProductPage());
              },),
            SizedBox(height: 16,),
            CustomButton(
              width: MediaQuery.of(context).size.width*.65,
              buttonName: "Log Out ",
              fontSize: 20,
              onTapFun: () {
                FirebaseAuth.instance.signOut();
                shiftByReplacement(context, Login());
              },),
          ],
        ),
      ),
    );
  }
}
