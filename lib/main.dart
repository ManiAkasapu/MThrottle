import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/themeprovider.dart';
import 'throttle/main.dart';

void main() {  
    //debugPaintSizeEnabled = true;
    runApp(
      ChangeNotifierProvider<ThemeManager>(
        create: (_) => ThemeManager(),
        child: MThrottle(),
      ),
    );
}
class MThrottle extends StatefulWidget {
  MThrottle({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  _MThrottleState createState() => _MThrottleState();
}

class _MThrottleState extends State<MThrottle> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    final themeManager = Provider.of<ThemeManager>(context);
    return MaterialApp(
      title: 'MThrottle',
      theme: themeManager.theme,
      home:  ThrottlePage(),
    );
  }
}

