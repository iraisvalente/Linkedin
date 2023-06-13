import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';
import "package:webview_universal/webview_universal.dart";
import 'package:project/models/connection.dart';
import 'package:project/service/http/connection.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  TextEditingController company = TextEditingController();
  TextEditingController position = TextEditingController();
  WebViewController webViewSearchController = WebViewController();
  WebViewController webViewLinkedinController = WebViewController();
  List<Connection>? listData = [];

  Future<void> connections(String company, String position) async {
    await searchConnection(company).then((value) {
      listData = [];
      listData = value;
    });
    setState(() {
      rows();
    });
  }

  List<DataRow> rows() {
    List<DataRow> rowList = [];
    for (int i = 0; i < listData!.length; i++) {
      rowList.add(DataRow(cells: [
        DataCell(Text(listData![i].firstname)),
        DataCell(Text(listData![i].lastname)),
        DataCell(Text(listData![i].email)),
        DataCell(Text(listData![i].company)),
        DataCell(Text(listData![i].position)),
        DataCell(Text(listData![i].connection!))
      ]));
    }
    return rowList;
  }

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
                      controller: company,
                      decoration:
                          const InputDecoration(hintText: 'Write the company'),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: TextField(
                      controller: position,
                      decoration:
                          const InputDecoration(hintText: 'Write the position'),
                    ),
                  ),
                  SizedBox(width: 40),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          connections(company.text, position.text);
                          String search = '${company.text}+${position.text}';
                          String replacedText = search.replaceAll(" ", "+");
                          webViewSearchController.init(
                            context: context,
                            setState: setState,
                            uri: Uri.parse(
                                "https://google.com/search?q=$replacedText"),
                          );
                          webViewLinkedinController.init(
                            context: context,
                            setState: setState,
                            uri: Uri.parse(
                                "https://google.com/search?q=$replacedText+linkedin"),
                          );
                        },
                        child: Text('Search')),
                  ),
                ],
              ),
            ),
            DataTable(columns: [
              DataColumn(label: Text('First Name')),
              DataColumn(label: Text('Last Name')),
              DataColumn(label: Text('Email Address')),
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Position')),
              DataColumn(label: Text('Connection')),
            ], rows: rows()),
            company.text == '' && position.text == ''
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 5,
                    width: MediaQuery.of(context).size.width,
                    child: WebView(
                      controller: webViewSearchController,
                    ),
                  )
                : Container(),
            company.text == '' && position.text == ''
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 5,
                    width: MediaQuery.of(context).size.width,
                    child: WebView(
                      controller: webViewLinkedinController,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
