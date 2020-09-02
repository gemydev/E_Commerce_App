import 'package:flutter/material.dart';

// Go and come back
void normalShift(BuildContext context, Object page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

// Go and don't come back
shiftByReplacement(BuildContext context, Object page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
