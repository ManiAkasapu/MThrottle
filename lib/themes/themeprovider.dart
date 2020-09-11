import 'package:flutter/material.dart';
import 'darkex.dart' show DarkEx;
import 'lightex.dart' show LightEx;


  final appThemeData = {
    "Darkex": DarkEx().theme,
    "Lightex": LightEx().theme,
  };

class ThemeManager with ChangeNotifier {
  
    ThemeData themeData;
    String themeName;

    ThemeData get theme{
      if (themeData == null) {
        themeData = appThemeData["Darkex"];
        themeName = "Darkex";
        print(themeData);
      }
      return themeData;
    }

    set (theme){
      themeData = appThemeData[theme];
      themeName = theme;
      notifyListeners();
    }
    String getThemeName(){
      return themeName;
    }

}