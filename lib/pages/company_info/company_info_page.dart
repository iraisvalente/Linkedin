import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';
import "package:webview_universal/webview_universal.dart";

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  TextEditingController search = TextEditingController();
  WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    webViewController.init(
      context: context,
      setState: setState,
      uri: Uri.parse("https://google.com"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            Container(
              margin: EdgeInsets.all(30),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: search,
                      decoration: const InputDecoration(
                          hintText: 'Write the search you want to perform'),
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                      height: 40,
                      width: 100,
                      child: Expanded(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Search')),
                      )),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              child: WebView(
                controller: webViewController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
