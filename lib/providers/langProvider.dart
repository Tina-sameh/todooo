import 'package:flutter/material.dart';
class LangProvider  extends ChangeNotifier{
  String currentLocale="en" ;


  void setCurrentLocale(String newLocale){
    currentLocale=newLocale ;
    notifyListeners();
  }
}