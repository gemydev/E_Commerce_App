import 'package:E_commerce/constants/colors.dart';
import 'package:flutter/cupertino.dart';


LinearGradient gradientFunIntro (){
  return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [GRADIENT_BEGIN, GRADIENT_END]
  );
}
LinearGradient gradientFunIntroCircle (){
  return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [GRADIENT_BEGIN, GRADIENT_END]
  );
}

LinearGradient gradientFunButtons (){
  return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [GRADIENT_BEGIN, GRADIENT_END]
  );
}