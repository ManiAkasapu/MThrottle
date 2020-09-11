

import 'package:flutter/material.dart';


class CustomColors{


///******DARKEX THEME CUSTOM COLORS*************************/
  final List<Color> darkexknobColors = [ 
        Color(0xff454545), 
        Color(0xff616060), 
        Color(0xff454545), 
        Color(0xff616060),
    ];
  final Color darkexTrackColor = Color(0xFF303030);
  final Color darkexHandleColor = Color(0xAA707070);
  final Color darkexIconColor =  Color(0xFF656565);
  final Color darkexIconActiveColor =  Colors.white;
  final Color darkexDirToggleColor = Color(0xFF303030);

///******LIGHTEX THEME CUSTOM COLORS*************************/

  final List<Color> lightexknobColors = [ 
        Color(0xffdadada), 
        Color(0xffb1b1b1), 
        Color(0xffdadada),
        Color(0xffb1b1b1),
    ];
  final Color lightexTrackColor =  Color(0xFF9E9E9E);
  final Color lightexHandleColor = Color(0x55616060);
  final Color lightexIconColor =  Color(0xFF797979);
  final Color lightexIconActiveColor =  Colors.white;
  final Color lightexDirToggleColor = Color(0x229E9E9E);
  
  
  getknobColor(theme){

    if(theme == "Darkex")
      return darkexknobColors;
    else if(theme == "Lightex")
      return lightexknobColors;
    else
      return null;

  }
  

  getSingleColor(theme, reqcolor){

    if(theme == "Darkex"){

      switch(reqcolor){

        case "iconColor":

          return darkexIconColor;

        case "iconActiveColor":

          return darkexIconActiveColor;

        case "trackColor":

          return darkexTrackColor;
          
        case "handleColor":

          return darkexHandleColor;

        case "dirToggleColor":

          return darkexDirToggleColor;

        default:

          return null;
      }
    }else 
    if(theme == "Lightex"){

      switch(reqcolor){

        case "iconColor":

          return lightexIconColor;

        case "iconActiveColor":

          return lightexIconActiveColor;

        case "trackColor":

          return lightexTrackColor;

        case "handleColor":

          return lightexHandleColor;
        
        case "dirToggleColor":

          return lightexDirToggleColor;

        default:

          return null;
      }
    }
  }


// Colors data for slider
//List<Color> sliderColors = 
  List<Color> sliderColors(){
    return [
      Color(0xffF60202),
      Color(0xffF60202),
      Color(0xffF60202),
      Color(0xffF60202),
      Color(0xffF60202),
      Color(0xffF69A1C),
      Color(0xffDBCE5D),
      Color(0xffDBCE5D),
      Color(0xff00D700),
      Color(0xff13D1AF),
      Color(0xff13D1AF),
      Color(0xff001AFF),
      Color(0xff001AFF),
      Color(0xff001AFF),
      Color(0xff001AFF),
      Color(0xff001AFF), 
    ];
  }

}


