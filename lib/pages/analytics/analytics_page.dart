import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Center(child: Text("AnalyticsPage page")),
        ],
      ),
    );
  }
}
