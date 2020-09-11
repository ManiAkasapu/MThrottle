import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'fnbtn.dart';

class FunctionButtons extends StatefulWidget {

  FunctionButtons({Key key, this.sendFunction}) : super(key: key);
  final cabFnCallback sendFunction;

  @override
  _FunctionButtonsState createState() => _FunctionButtonsState();
}

class _FunctionButtonsState extends State<FunctionButtons> {

  Timer _timer;
  var fndata = <String, List>{
      'f0': [0, 0, "Head Light"], // Index => 0=state, 1=type, 3=Name
      'f1': [0, 1, "Bell"], 
      'f2': [0, 1, "Horn"], 
      'f3': [0, 0, "F3"],
      'f4': [0, 0, "F4"],
      'f5': [0, 0, "F5"], 
      'f6': [0, 0, "F6"], 
      'f7': [0, 0, "F7"],
      'f8': [0, 0, "F8"],
      'f9': [0, 0, "F9"],
      'f10': [0, 0, "F10"], 
      'f11': [0, 0, "F11"], 
      'f12': [0, 0, "F12"],
      'f13': [0, 0, "F13"],
      'f14': [0, 0, "F14"],
      'f15': [0, 0, "F15"], 
      'f16': [0, 0, "F16"], 
      'f17': [0, 0, "F17"],
      'f18': [0, 0, "F18"],
      'f19': [0, 0, "F19"],
      'f20': [0, 0, "F20"], 
      'f21': [0, 0, "F21"], 
      'f22': [0, 0, "F22"],
      'f23': [0, 0, "F23"],
      'f24': [0, 0, "F24"],
      'f25': [0, 0, "F25"], 
      'f26': [0, 0, "F26"], 
      'f27': [0, 0, "F27"],
      'f28': [0, 0, "F28"],
  };

  
void generateFnCommand(context, func){
       switch(func){

            case "f0":
            case "f1":
            case "f2":
            case "f3":
            case "f4":
            { 
                var cabVal = (128+fndata["f1"][0]*1 + fndata["f2"][0]*2 + fndata["f3"][0]*4  + fndata["f4"][0]*8 + fndata["f0"][0]*16);
                widget.sendFunction(cabVal.toString());
                Toast.show("F0-F4 => Command : $cabVal", context, duration: 500, gravity:  Toast.BOTTOM);  
                break;             
            }
            case "f5":
            case "f6":
            case "f7":
            case "f8":
            { 

                var cabVal = (176+fndata["f5"][0]*1 + fndata["f6"][0]*2 + fndata["f7"][0]*4  + fndata["f8"][0]*8);
                widget.sendFunction(cabVal.toString());
                Toast.show("F5-F8 => Command : $cabVal", context, duration: 500, gravity:  Toast.BOTTOM);  
                break;
            }
            case "f9":
            case "f10":
            case "f11":
            case "f12":
            { 
                var cabVal = (160+fndata["f9"][0]*1 + fndata["f10"][0]*2 + fndata["f11"][0]*4  + fndata["f12"][0]*8);
                widget.sendFunction(cabVal.toString());
                Toast.show("F9-F12 => Command : $cabVal", context, duration: 500, gravity:  Toast.BOTTOM);  
                break;
            }
            case "f13":
            case "f14":
            case "f15":
            case "f16":
            case "f17":
            case "f18":
            case "f19":
            case "f20":
            { 
              var cabVal = (fndata["f13"][0]*1 + fndata["f14"][0]*2 + fndata["f15"][0]*4  + fndata["f16"][0]*8 + fndata["f17"][0]*16 + fndata["f18"][0]*32 + fndata["f19"][0]*64 + fndata["f20"][0]*128);
              widget.sendFunction("222 "+cabVal.toString());
              Toast.show("F13-F20 => Command : $cabVal", context, duration: 500, gravity:  Toast.BOTTOM);                 
              break;
            }
            case "f21":
            case "f22":
            case "f23":
            case "f24":
            case "f25":
            case "f26":
            case "f27":
            case "f28":
            { 
              var cabVal = (fndata["f21"][0]*1 + fndata["f22"][0]*2 + fndata["f23"][0]*4  + fndata["f24"][0]*8 + fndata["f25"][0]*16 + fndata["f26"][0]*32 + fndata["f27"][0]*64 + fndata["f28"][0]*128);
              widget.sendFunction("223 "+cabVal.toString());
              Toast.show("F21-F28 => Command : $cabVal", context, duration: 500, gravity:  Toast.BOTTOM);  
              break;
            }
            default:
            {   
              Toast.show("Invalid Function", context, duration: 500, gravity:  Toast.BOTTOM);
            } 

       }          
  }


  @override
  Widget build(BuildContext context) {
    return Container( 
      height: 780,
      child: GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: fndata.length, //fndata.values/keys.elementAt(index)  
      itemBuilder: (BuildContext context, int index) {
            var key = fndata.keys.elementAt(index);
            var val = fndata.values.elementAt(index);

            return Container(
              margin: EdgeInsets.all(8),
              child: FuntionButton(
                btnText: val[2],
                btnState: val[0],
                 onTapDown:(TapDownDetails details){ 
                    _timer = Timer.periodic(Duration(milliseconds: 50), (t) {     
                        if(val[1] == 1){
                          print("DOWN"+val[2]);
                          setState(() {
                              val[0] = 1;
                              generateFnCommand(context, key);                                 
                          }); 
                        }

                    });
                },

                onTapUp:(TapUpDetails details){
                  if(val[1] == 1){
                    _timer.cancel();
                    print("UP"+val[2]);
                    setState(() {
                      val[0] = 0;
                      generateFnCommand(context, key);  
                    });
                  }
                },

                onTapCancel:(){
                  if(val[1] == 1){
                    _timer.cancel();
                    print("UP"+val[2]);
                    setState(() {
                      val[0] = 0;
                      generateFnCommand(context, key);  
                    });
                  }
                },

                onTap: (){  
                  if(val[1] == 0){
                   setState(() {
                      if (val[0] == 0){
                        val[0] = 1;
                        generateFnCommand(context, key);
                      }else{
                        val[0] = 0;
                        generateFnCommand(context, key);
                      }
                    });
                   // widget.sendFunction(val[0].toString());
                  }
                }
              ),
            );
          },
      )
    );
  }
}

// !IMPORTANT Helpers to pass functions to Throttle parent
typedef cabFnCallback = Function(String fn);




  /*    Single Function button - Keeping this Reference 
        child: GridView.count(
          crossAxisCount: 4,
          padding: EdgeInsets.symmetric(horizontal: 16),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 2/2.2,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>
          [ 
            FuntionButton(
              btnText: "F0",
              btnState: fndata['f0'][0],
              onTapDown:(TapDownDetails details){ 
              _timer = Timer.periodic(Duration(milliseconds: 50), (t) {     
                  if(fndata['f0'][1] == 1){
                    print("DOWN"+fndata['f0'][2]);
                    setState(() {
                        fndata['f0'][0] = 1;
                        widget.sendFunction(fndata['f0'][0].toString());                                 
                    }); 
                  }

                });
              },
              onTapUp:(TapUpDetails details){
                if(fndata['f0'][1] == 1){
                  _timer.cancel();
                  print("UP"+fndata['f0'][2]);
                  setState(() {
                    fndata['f0'][0] = 0;
                    widget.sendFunction(fndata['f0'][0].toString());  
                  });
                }
              },
              onTap: (){  
                if(fndata['f0'][1] == 0){
                  setState(() {
                    if (fndata['f0'][0] == 0){
                      fndata['f0'][0] = 1;
                    }else{
                      fndata['f0'][0] = 0;
                    }
                  });
                  print("DOWN"+(fndata.length).toString());
                  widget.sendFunction(fndata['f0'][0].toString());
                }
              }
            ),
              
          ],
        ),  
      */