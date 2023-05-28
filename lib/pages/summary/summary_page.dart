import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Center(child: Text("Summary Page")),
        ],
      ),
    );
  }
}
