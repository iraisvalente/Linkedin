import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:webview_universal/webview_universal.dart";
import 'package:project/models/connection.dart';
import 'package:project/service/http/connection.dart';
import 'package:string_similarity/string_similarity.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  TextEditingController company = TextEditingController();
  TextEditingController position = TextEditingController();
  ScrollController scrollController = ScrollController();
  WebViewController webViewSearchController = WebViewController();
  WebViewController webViewLinkedinController = WebViewController();
  List<Connection>? listData = [];
  Directory current = Directory.current;
  String prueba = '';
  String search = '';
  String bardResult = '';

  Future<void> connections(String company) async {
    await searchConnection(company).then((value) {
      listData = [];
      listData = value;
    });
    setState(() {
      rows();
    });
  }

  Future<Connection?> connection(String firstname, String lastname) async {
    Connection? connection;
    await bardConnection(Connection.bardSearch(firstname, lastname))
        .then((value) {
      connection = value;
    });
    return connection;
  }

  void bardSearch() async {
    String script = current.absolute.uri.toString() + "bard.py";
    script = script.split("file:///")[1];
    print('WORK IN PROGRESS');
    String conc = '${company.text}+${position.text}';
    print(company.text);
    print(position.text);
    print(script);
    var result =
        await Process.run("python", [script, company.text, position.text]);
    if (result.exitCode != 0) {
      print("Erorr en bard");
      print(result.exitCode);
      if (result.exitCode == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Secure-1PSID ::: Invalid')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error searching with bard')),
        );
      }
    } else {
      print('DONE');
      print(result.stdout.toString());
      conc = result.stdout.toString();
      bardResult = result.stdout.toString();
      search = conc.split("\n")[0];
      String replacedText = search.replaceAll(" ", "+");
      alertConnectionFound(search);
      connections(company.text);
      prueba = search;
    }
  }

  void alertConnectionFound(result) async {
    String fullname = result.split(".")[0].toString().toUpperCase();
    String firstname = fullname.split(' ')[0];
    String lastname = fullname.split(' ')[1];
    Connection? searchConnection = await connection(firstname, lastname);
    if (searchConnection!.firstname != null &&
        searchConnection.lastname != null) {
      print('encontrado');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Search found in your connections'),
          content: Text(
              '${searchConnection.firstname} ${searchConnection.lastname} has been found in your connections'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  List<DataRow> rows() {
    List<DataRow> rowList = [];
    String fullname = search.split(".")[0].toString().toUpperCase();
    String firstname = fullname.split(' ')[0];
    String lastname = fullname.split(' ')[1];

    for (int i = 0; i < listData!.length; i++) {
      String linkedinLink = '';
      if (listData![i].firstname!.toUpperCase().similarityTo(firstname) > 0.7 &&
          listData![i].lastname!.toUpperCase().similarityTo(lastname) > 0.7) {
        List<dynamic> listResume = bardResult.split(".").sublist(1);

        linkedinLink =
            'https://www.${listResume[listResume.length - 2]}.${listResume.last}'
                .trim();
      }
      rowList.add(DataRow(cells: [
        DataCell(Text(listData![i].firstname!)),
        DataCell(Text(listData![i].lastname!)),
        DataCell(Text(listData![i].email!)),
        DataCell(Text(listData![i].company!)),
        DataCell(Text(listData![i].position!)),
        DataCell(Text(listData![i].connection!)),
        DataCell(TextButton(
          onPressed: () async {
            final Uri url = Uri.parse(linkedinLink);
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
            }
          },
          child: Text(linkedinLink),
        )),
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
                          bardSearch();
                        },
                        child: Text('Search')),
                  ),
                ],
              ),
            ),
            bardResult != ''
                ? Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: SingleChildScrollView(
                            child: SelectableText(bardResult)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Scrollbar(
                          controller: scrollController,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: scrollController,
                              child: DataTable(columns: [
                                DataColumn(label: Text('First Name')),
                                DataColumn(label: Text('Last Name')),
                                DataColumn(label: Text('Email Address')),
                                DataColumn(label: Text('Company')),
                                DataColumn(label: Text('Position')),
                                DataColumn(label: Text('Connection')),
                                DataColumn(label: Text('Link to LinkedIn'))
                              ], rows: rows()))),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          String? outputFile =
                              await FilePicker.platform.saveFile(
                            dialogTitle: 'Select the folder to save the file:',
                            fileName: 'company_info.csv',
                          );

                          if (outputFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('The file was not exported')),
                            );
                          } else {
                            List<List<dynamic>> rows = [];
                            rows.add([
                              "First Name",
                              "Last Name",
                              "Email Address",
                              "Company",
                              "Position",
                              "Connection",
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
                            String csv =
                                const ListToCsvConverter().convert(rows);
                            File file = File(outputFile!);
                            await file.writeAsString(csv);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('File exported successfully')),
                            );
                          }
                        },
                        child: Text('Export to CSV'),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
