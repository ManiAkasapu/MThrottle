import 'dart:async';
import '../themes/customcolors.dart';
import '../themes/themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ThrottleKnob extends StatefulWidget {

  ThrottleKnob({Key key, this.setThrottleDetails, this.serverStatus}) : super(key: key);

  final throttleCallback setThrottleDetails;
  final bool serverStatus;

  @override
  _ThrottleKnobState createState() => _ThrottleKnobState();

}

class _ThrottleKnobState extends State<ThrottleKnob> {

  int _speed;
  int _speedStep;

  Timer _timer;
  bool _isStopped; 

  int _direction;
  double dirBtnPos;
  Color dirBtnColor;
  double animWidth;
  double animPos;
  int curdir;

  @override
  void initState() {
    super.initState();
    _speed = 0;
    _speedStep = 4;
    _isStopped = false;
    _direction = 1;
      curdir = 1;
      dirBtnPos = 224;
      animWidth = 150;
      animPos = 224;
      dirBtnColor = Colors.teal;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  final thmeName = Provider.of<ThemeManager>(context).themeName; 
  final cColor = new CustomColors();


  SleekCircularSlider  circularSlider =  SleekCircularSlider(
      min: 0,
      max: 126,
      initialValue: (!_isStopped) ? _speed.toDouble(): 0,
      appearance: CircularSliderAppearance(
          size: 180,
          startAngle: 130,
          angleRange: 280,
          animationEnabled: false,
          customWidths: CustomSliderWidths(
            trackWidth: 20,
            progressBarWidth: 18,
            shadowWidth: 1,
            handlerSize: 22,
          ),
          customColors: CustomSliderColors(
          trackColor: cColor.getSingleColor(thmeName, 'trackColor'),
          progressBarColors: cColor.sliderColors(),
            shadowMaxOpacity: 1,
            shadowColor: cColor.getSingleColor(thmeName, 'trackColor'), 
            dotColor: cColor.getSingleColor(thmeName, 'handleColor'),                                           
          ),
          infoProperties: InfoProperties(
              mainLabelStyle: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w100,
                height: 3.8,                  
              ),
              /* bottomLabelText: "Speed",
                bottomLabelStyle : TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70                         
              ),
              modifier: (double value){
                final roundedValue = value.ceil().toInt().toString();
                return '$roundedValue';
              },*/
            ),
        ),
        onChange: (double value) {
            var spd = value.toInt();
            //setState(() {
              _speed = ((spd >= 1) && !_isStopped ) ? spd : _speed;                                
            //});                          

        },
        onChangeEnd: (double value) {
          setState(() {
            widget.setThrottleDetails(_direction, _speed); 
            print(_speed);
          });                
        },
        innerWidget:(double value){
          return Container( 
            alignment: Alignment.bottomCenter,
            //margin: EdgeInsets.all(20),
            width: 100,
            height: 50, 
            child: Text( 
              (value).round().toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'TulpenOne',
                fontWeight: FontWeight.w300,
                fontSize: 48,
                color: Theme.of(context).inputDecorationTheme.labelStyle.color,
              ),                            
              ),
          );
      },
  );

  return Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        AbsorbPointer(
        absorbing: _isStopped,
        child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                      ),
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          _timer = Timer.periodic(Duration(milliseconds: 50), (t) {
                              var spd = _speed - _speedStep;
                              setState(() {
                                _speed = ((spd >= 1) && !_isStopped ) ? spd : _speed;                                
                              }); 
                              print(_speed);                      
                            });
                        },    
                        onTapUp: (TapUpDetails details) {
                          _timer.cancel();
                          setState(() {
                            widget.setThrottleDetails(_direction, _speed);
                          });
                        },
                        onTapCancel: () {
                          _timer.cancel();
                          setState(() {
                            widget.setThrottleDetails(_direction, _speed);
                          });
                        },
                        child: IconButton(                           
                            iconSize: 64.0,
                            color: cColor.getSingleColor(thmeName, 'iconColor'),
                            icon: Icon(
                              Icons.chevron_left,                          
                            ),
                            onPressed: () {
                             var spd = _speed - _speedStep;
                              setState(() {
                                _speed = ((spd >= 1) && !_isStopped ) ? spd : _speed;                                
                              }); 
                              widget.setThrottleDetails(_direction, _speed);
                              print(_speed);                    
                            }
                          ),
                      ),
                    ),
                  ),
                ),
                Stack(                   
                children: [
                    Container(
                        width: 190,
                        height: 190,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          boxShadow:  [
                            BoxShadow(color: const Color(0xFF303030), spreadRadius: 1),
                          ],
                          borderRadius: BorderRadius.circular(200),
                          gradient: new SweepGradient(
                            startAngle: 0,
                            endAngle: 15,
                            colors: cColor.getknobColor(thmeName),
                            /*
                            [ 
                              Color(0xffA7A7A7), 
                              Color(0xff787878), 
                              Color(0xffA7A7A7), 
                              Color(0xff787878),],*/
                            stops: [0.05,0.15,0.45, 2],
                          ),
                        ),
                    ),
                    Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: circularSlider,

                    )
                  ]
                ),
                Material(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                      ),
                      child: GestureDetector(
                        onTapDown: (TapDownDetails details){
                          _timer = Timer.periodic(Duration(milliseconds: 50), (t) {
                            var spd = _speed + _speedStep;
                            setState(() {
                              _speed = ((spd <= 128) && !_isStopped ) ? spd : _speed;                                
                            }); 
                            widget.setThrottleDetails(_direction, _speed);
                            print(_speed); 
                          });
                        },
                        onTapUp: (TapUpDetails details) {
                          _timer.cancel();
                          widget.setThrottleDetails(_direction, _speed);  
                        },
                        onTapCancel: () {
                          _timer.cancel();
                          widget.setThrottleDetails(_direction, _speed);
                        },
                        child: IconButton(
                            iconSize: 64.0,
                            color: cColor.getSingleColor(thmeName, 'iconColor'),
                            icon: Icon(                             
                              Icons.chevron_right,
                            ),
                            onPressed: () {
                              var spd = _speed + _speedStep;
                              setState(() {
                                _speed = ((spd <= 128) && !_isStopped ) ? spd : _speed;                                
                              }); 
                              widget.setThrottleDetails(_direction, _speed);
                              print('$_speed , $_isStopped'); 
                            }
                          ),
                      ),
                    ),
                  ),
                ),
            ]
          ),
        ), 
        
        Row(
              children: [ 
                Container(
                height: 20.0,
                alignment: Alignment.center,
                ),
          ]
        ), 

        Container(
            width: 304,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 1),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                alignment: Alignment.center,
                color: cColor.getSingleColor(thmeName, 'dirToggleColor'),
                //heightFactor: 1,
                //widthFactor: 1,
                child: Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 680),
                      curve: Curves.fastOutSlowIn,
                      left: animPos,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        height: 64,
                        width: animWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: dirBtnColor,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastOutSlowIn,
                      left: dirBtnPos,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        height: 64,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: dirBtnColor,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Material(
                            color: Colors.transparent,
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(100.0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_left),
                              color: (curdir == 0) ?  cColor.getSingleColor(thmeName, 'iconActiveColor') :  cColor.getSingleColor(thmeName, 'iconColor'),
                              iconSize: 48,
                              onPressed: () {
                                setState(() {
                                  _direction = 0;
                                   curdir = 0;
                                   dirBtnPos = 0;
                                   animWidth = 150;
                                   animPos = -70;
                                   dirBtnColor = Colors.teal;
                                  _isStopped = false;
                                  _speed = _speed;
                                   widget.setThrottleDetails(_direction, _speed);
                                });
                              },
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 45),
                          //alignment: Alignment.center,
                          child: Material(
                            color: Colors.transparent,
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(100.0),
                            child: IconButton(
                              icon: Icon(Icons.stop),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(12),
                              color: (curdir == -1) ?  cColor.getSingleColor(thmeName, 'iconActiveColor') :  cColor.getSingleColor(thmeName, 'iconColor'),
                              iconSize: 40,
                              onPressed: () {
                                setState(() {
                                  curdir = -1;
                                  dirBtnPos = 112;
                                  animWidth = 80;
                                  animPos = 112;
                                  dirBtnColor = Colors.red;
                                 _isStopped = true;
                                 _speed = 0;
                                  widget.setThrottleDetails(_direction, -1);
                                });
                              },
                            ),
                          ),
                        ),
                        new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Material(
                            color: Colors.transparent,
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(100.0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_right), //darkexIconActiveColor
                              color: (curdir == 1) ? cColor.getSingleColor(thmeName, 'iconActiveColor') :  cColor.getSingleColor(thmeName, 'iconColor'),
                              iconSize: 48,
                              onPressed: () {
                                setState(() {
                                  _direction = 1;
                                  curdir = 1;
                                  dirBtnPos = 224;
                                  animWidth = 150;
                                  animPos = 224;
                                  dirBtnColor = Colors.teal;
                                 _isStopped = false;
                                 _speed = _speed;
                                  widget.setThrottleDetails(_direction, _speed);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        
        Row(
          children: [ 
            Container(
            height: 20.0,
            alignment: Alignment.center,
            ),
          ]
        ),
      ]
    ),

  );
  }

}
// !IMPORTANT Helpers to pass functions to Throttle parent
typedef throttleCallback = Function(int dir , int speed);