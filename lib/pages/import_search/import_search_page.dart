import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class ImportSearchPage extends StatelessWidget {
  const ImportSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(),
          Center(child: Text("import search page")),
        ],
      ),
    );
  }
}
