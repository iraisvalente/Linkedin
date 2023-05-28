import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/widgets/navbar_button.dart';
import 'package:project/widgets/navbar_item.dart';
import 'package:project/pages/login.dart';
import 'package:project/pages/register.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double collapsableHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [
      NavBarItem(
        text: 'Login',
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Login()));
        },
      ),
      NavBarItem(
        text: 'Register',
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Register()));
        },
      ),
    ];
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        AnimatedContainer(
          margin: EdgeInsets.only(top: 79.0),
          duration: Duration(milliseconds: 375),
          curve: Curves.ease,
          height: (width < 800.0) ? collapsableHeight : 0.0,
          width: double.infinity,
          color: Color(0xff121212),
          child: SingleChildScrollView(
            child: Column(
              children: navBarItems,
            ),
          ),
        ),
        Container(
          color: Colors.blue.shade900,
          height: 80.0,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LayoutBuilder(builder: (context, constraints) {
                if (width < 800.0) {
                  return NavBarButton(
                    onPressed: () {
                      if (collapsableHeight == 0.0) {
                        setState(() {
                          collapsableHeight = 240.0;
                        });
                      } else if (collapsableHeight == 240.0) {
                        setState(() {
                          collapsableHeight = 0.0;
                        });
                      }
                    },
                  );
                } else {
                  return Row(
                    children: navBarItems,
                  );
                }
              })
            ],
          ),
        ),
      ],
    );
  }
}
