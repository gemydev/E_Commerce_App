
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{

  bool darkModeSelected = false ;
  bool arabicSelected = false ;
  bool englishSelected = true ;


  void selectDark(bool value){
    darkModeSelected = value;
    notifyListeners();
  }
  void selectArabic(bool value){
    arabicSelected = value;
    englishSelected = !value;
    notifyListeners();
  }
  void selectEnglish(bool value){
    englishSelected = value;
    arabicSelected = !value;
    notifyListeners();
  }

}