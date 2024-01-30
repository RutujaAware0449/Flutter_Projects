import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_application/themes/dark_mode.dart';
import 'package:flutter_chat_application/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themedata( ThemeData themeData){
    _themeData= themeData;
    notifyListeners();


    void toggleThemeData(){
      if(_themeData==lightMode){
        themedata= darkMode;
      }else{
        themedata= lightMode;
      }
    }
  }
}