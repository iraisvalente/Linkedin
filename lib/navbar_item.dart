import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

double collapsableHeight = 0.0;
Color selected = Color(0xffffffff);
Color notSelected = Color(0xafffffff);

class NavBarItem extends StatefulWidget {
  final String text;
  final Function function;
  NavBarItem({
    super.key,
    required this.text,
    required this.function,
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  Color color = notSelected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => widget.function(),
        child: Text(
          widget.text,
          style: TextStyle(color: Colors.white),
        ));
  }
}
