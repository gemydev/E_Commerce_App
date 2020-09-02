import 'package:flutter/material.dart';

delayedFun(BuildContext context) async{
  await new Future.delayed(const Duration(seconds: 2));
  Navigator.of(context).pop();
}