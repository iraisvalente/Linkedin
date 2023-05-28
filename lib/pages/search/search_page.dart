import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Center(child: Text("Search page")),
        ],
      ),
    );
  }
}
