import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/analytics/analytics_page.dart';
import 'package:project/pages/import_search/import_search_page.dart';
import 'package:project/pages/saved_search/saved_search_page.dart';
import 'package:project/pages/search/search_page.dart';
import 'package:project/pages/summary/summary_page.dart';
import 'package:project/pages/home.dart';
import 'package:project/widgets/navbar_button.dart';
import 'package:project/widgets/navbar_item.dart';
import 'package:project/pages/login.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  double collapsableHeight = 0.0;

  dynamic displayBar(BuildContext context, String text, {bool cancel = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: !cancel ? Text("Click Item $text") : Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = [
      NavBarItem(
        text: 'Home',
        function: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => Login()));
        },
      )
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
                    children: [
                      NavBarItem(
                        text: 'Home',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Home()));
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      PopupMenuButton(
                          itemBuilder: (_) {
                            return [
                              PopupMenuItem(
                                  value: "Analytics", child: Text("Analytics")),
                              PopupMenuItem(
                                  value: "Summary", child: Text("Summary")),
                            ];
                          },
                          onSelected: (i) {
                            if (i == "Analytics") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          AnalyticsPage()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SummaryPage()));
                            }
                          },
                          child: Text(
                            "Analytics",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      PopupMenuButton(
                          itemBuilder: (_) {
                            return [
                              PopupMenuItem(
                                  value: "Search", child: Text("Search")),
                              PopupMenuItem(
                                  value: "Import Search",
                                  child: Text("Import Search")),
                              PopupMenuItem(
                                  value: "Saved Search",
                                  child: Text("Saved Search")),
                            ];
                          },
                          onSelected: (i) {
                            if (i == "Search") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SearchPage()));
                            } else if (i == "Import Search") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ImportSearchPage()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SavedSearchPage()));
                            }
                          },
                          child: Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
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
