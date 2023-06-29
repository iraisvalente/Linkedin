import 'dart:io';

import 'package:flutter/material.dart';

import 'package:project/widgets/navbar_init.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Directory current = Directory.current;
  String privacyPolicy = '';

  Future<String> readCsv(String path) async {
    final File file = File(path);
    String contents = await file.readAsString();
    return contents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      privacyPolicy =
          await readCsv('${current.path}/assets/txt/privacy_policy.txt');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        NavBar(),
        Container(
          height: 100,
          child: Center(child: Text(privacyPolicy)),
        )
      ],
    ));
  }
}
