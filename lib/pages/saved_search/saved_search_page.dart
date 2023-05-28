import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class SavedSearchPage extends StatelessWidget {
  const SavedSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Center(child: Text("SavedSearch page")),
        ],
      ),
    );
  }
}
