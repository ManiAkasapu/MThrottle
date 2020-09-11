import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get btnColor => Colors.amber;
}

class LightEx{
  LightEx();
  /// Default constructor

  ThemeData get theme{

    ButtonThemeData buttonScheme = ButtonThemeData(
       alignedDropdown: false, 
       buttonColor: const Color(0xFF00A3B9), 
       disabledColor:const Color(0xFF008395),
       focusColor:  const Color(0xFF00BAC6),
       hoverColor:  const Color(0xFF00BAC6), 
       highlightColor: const Color(0xFF03A7B1),
       splashColor: Colors.white, 
    );

    // inputDecorationTheme
    InputDecorationTheme inputTheme = InputDecorationTheme(
       errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5)),               
       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00A3B9), width: 1)),
       focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFff0000), width: 1)),
       disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF454545), width: 0.5)),
       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF575757), width: 1)),
       border:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF575757) , width: 0.5)),
       labelStyle: TextStyle(color: Color(0xFF454545)),
       hintStyle: TextStyle(color: Color(0xFF5E5E5E)),
    );

    TabBarTheme tabTheme =   TabBarTheme(

      labelColor: Color(0xFF373737),
      unselectedLabelColor: Color(0xFF454545),
      labelPadding: EdgeInsets.all(3),
      indicator: BoxDecoration(
      border: Border(
          bottom: BorderSide(
            color: const Color(0xFF454545),     
            width: 3,
          ),
        ),
      ),

    );

    var th = ThemeData(
        primaryColor: Color(0xFF00A3B9), // Primary
        accentColor: Color(0xFF007E8E),
        canvasColor: Color(0xFFD9D9D9),
        scaffoldBackgroundColor:  Color(0xFFEDEDED), // App Background
        backgroundColor: Color(0xFFECECEC), 
        cardColor: Color(0xAAB2B2B2), // Card() Background
        buttonTheme: buttonScheme,
        inputDecorationTheme: inputTheme,
        tabBarTheme: tabTheme,
    );
 

    // Return the themeData which MaterialApp can now use
    return th;
  }

}
