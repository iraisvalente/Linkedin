import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
  Directory current = Directory.current;


  Future<void> connections(String company) async {
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

    String script = current.absolute.uri.toString() + "bard.py";

    script = script.split("file:///")[1];

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
                        onPressed: () async {
                          print(script);
                          print(company.text);
                          print(position.text);
                          String conc = '${company.text}+${position.text}';
                          //connections(company.text, position.text);
                          var result = await Process.run("python", [
                            script,
                            company.text,
                            position.text
                          ]);
                          if (result.exitCode != 0) {
                            print("Erorr en bard");
                          } else {
                            print(result.stdout.toString());
                          }
                          conc = result.stdout.toString();
                          String search = conc;

                          connections(company.text);
                          //String search = '${company.text}+${position.text}';
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

                        child: Text('Search')
    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                : Container(),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                print(listData!.length);
                List<List<dynamic>> rows = [];
                rows.add([
                  "First Name",
                  "Last Name",
                  "Email Address",
                  "Company",
                  "Position",
                  "Connection"
                ]);
                for (Connection connection in listData!) {
                  rows.add([
                    connection.firstname,
                    connection.lastname,
                    connection.email,
                    connection.company,
                    connection.position,
                    connection.connection
                  ]);
                }
                String csv = const ListToCsvConverter().convert(rows);
                Directory appDir = await getApplicationDocumentsDirectory();
                String appPath = appDir.path;
                File file = File("$appPath/company_info.csv");
                await file.writeAsString(csv);
                print("File exported successfully!");
              },
              child: Text('Export to CSV'),
            )
          ],
        ),
      ),
    );
  }
}
