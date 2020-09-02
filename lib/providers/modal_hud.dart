import 'package:flutter/widgets.dart';

class ModalProgress extends ChangeNotifier{

  bool callValue = false ;

  inAsyncCallFun(bool value){
    callValue = value ;
    notifyListeners();
  }

}