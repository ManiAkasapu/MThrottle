import 'package:flutter/material.dart';

class FuntionButton extends StatelessWidget {
  FuntionButton(
      {this.onTap,
      this.onTapDown,
      this.onTapUp,
      this.onTapCancel,
      @required this.btnText,
      this.btnState});

  final GestureTapCallback onTap;
  final GestureTapDownCallback onTapDown;
  final GestureTapUpCallback onTapUp;
  final GestureTapCancelCallback onTapCancel;
  final String btnText;
  final int btnState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onTapCancel: onTapCancel,
        child: Material(
          color: btnState == 1
              ? Theme.of(context).accentColor.withAlpha(200)
              : Theme.of(context).primaryColor,
          elevation: btnState == 1 ? 0 : 5,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(4),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Theme.of(context).accentColor.withAlpha(200),
                width: 3,
              )),
            ),
            child: Text(
              btnText,
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                      blurRadius: 1.0,
                      color: Colors.black,
                      offset: Offset(0.5, 0.7),
                      ),
                ],                
              ),
            ),
          ),
        ),
    );
  }
}