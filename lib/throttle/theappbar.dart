import 'package:flutter/material.dart';

class TheAppBar extends StatefulWidget implements PreferredSizeWidget {
  TheAppBar({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TheAppBarState createState() => _TheAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _TheAppBarState extends State<TheAppBar> {

  @override
  Widget build(BuildContext context) {

    return AppBar(
          title: Text(widget.title),
          bottomOpacity: 0.0,
          elevation: 0.0,
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () {},
            ),
            // action button
          ],
        );
  }
}