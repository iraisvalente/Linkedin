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
                            onPressed: () {
                              String replacedText =
                                  search.text.replaceAll(" ", "+");
                              webViewController.init(
                                context: context,
                                setState: setState,
                                uri: Uri.parse(
                                    "https://google.com/search?q=$replacedText"),
                              );
                            },
                            child: Text('Search')),
                      )),
                ],
              ),
            ),
            search.text == ''
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 5,
                    width: MediaQuery.of(context).size.width,
                    child: WebView(
                      controller: webViewController,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
