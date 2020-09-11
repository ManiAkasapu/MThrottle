import 'package:flutter/material.dart';

class DarkEx{

    DarkEx();
    ThemeData get theme{ 

    ButtonThemeData buttonTheme = ButtonThemeData(
       alignedDropdown: false, 
       buttonColor: const Color(0xFF00A3B9), 
       disabledColor:const Color(0xFF008395),
       focusColor:  const Color(0xFF00BAC6),
       hoverColor:  const Color(0xFF00BAC6), 
       highlightColor: const Color(0xFF03A7B1),
       splashColor: Colors.white, 
    );

    SnackBarThemeData snackbarTheme = SnackBarThemeData(
      backgroundColor: const Color(0xFF272728),
      contentTextStyle: TextStyle( color: Colors.white ), 
    );

    IconThemeData iconThm = new IconThemeData(
      color: Colors.grey,
    );

    InputDecorationTheme inputTheme = InputDecorationTheme(
       errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5)),               
       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF00A3B9), width: 1)),
       focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFff0000), width: 1)),
       disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF575757), width: 0.5)),
       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFECECEC), width: 1)),
       border:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFECECEC) , width: 0.5)),
       labelStyle: TextStyle(color: Color(0xFFEDEDED)),
       hintStyle: TextStyle(color: Colors.grey),
    );

    TabBarTheme tabTheme =   TabBarTheme(
      labelPadding: EdgeInsets.all(3),
      indicator: BoxDecoration(
        border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFFFFFFFF),     
                          width: 3,
                        ),
                      ),
      ),

    );

    var th = ThemeData(
        primaryColor: Color(0xFF00A3B9), // Primary
        accentColor: Color(0xFF007E8E),
        canvasColor:  Color(0xFF373737),
        scaffoldBackgroundColor: Color(0xFF373737), // App Background
        backgroundColor: Color(0xFF454545),
        cardColor: Color(0xFF454545), // Card() Background
        buttonTheme: buttonTheme,
        snackBarTheme: snackbarTheme,
        //colorScheme: ThemeData.dark().colorScheme, // Copy Form dark() theme       
        textTheme: ThemeData.dark().textTheme, // Copy Form dark() theme
        inputDecorationTheme: inputTheme,
        iconTheme: iconThm,
        tabBarTheme: tabTheme,
    );
 
    // Return the themeData which MaterialApp can now use
    return th;
    
  }
}
