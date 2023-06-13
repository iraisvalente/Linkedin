import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'package:file_picker/file_picker.dart';

class CompanyPositionPage extends StatefulWidget {
  const CompanyPositionPage({super.key});

  @override
  State<CompanyPositionPage> createState() => _CompanyPositionPageState();
}

class _CompanyPositionPageState extends State<CompanyPositionPage> {
  String fileName = "No file chosen";
  String path = "";
  Directory current = Directory.current;

  List<DataRow> _rowList = [];
  List<DataRow> rows = [];
  List<TextEditingController> _controllerList = [];
  List<List<String>> _answerContent = [];

  Future readCsv(String path) async {
    final File file = File(path);
    String contents = await file.readAsString();
    List<String> lines = contents.split('\n');
    lines.removeLast();
    return lines;
  }

  void _addRow() {
    int index = _rowList.length;
    TextEditingController controller = TextEditingController();
    _controllerList.add(controller);
    setState(() {
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(
          TextFormField(
            keyboardType: TextInputType.text,
            controller: controller,
          ),
        ),
        DataCell(Icon(Icons.delete), onTap: () {
          _deleteRow(index);
        }),
      ]));
    });
  }

  void _deleteRow(int index) {
    _rowList.removeAt(index);
    setState(() {
      print(index);
      _rowList;
    });
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
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.20,
                  right: MediaQuery.of(context).size.width * 0.20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Import company position",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Select  CSV or Excel file",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.grey.shade400;
                            }
                            return Colors.grey.shade300;
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return Colors.black54;
                          }),
                        ),
                        onPressed: () async {
                          var picked = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'csv',
                                'xlsx',
                                'xlsm',
                                'xlsb',
                                'xltx'
                              ]);
                          if (picked != null) {
                            path = picked.files.first.path.toString();
                            fileName = picked.files.first.name;
                            setState(() {
                              fileName = fileName;
                            });
                          }
                        },
                        child: const Text('Choose File'),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        fileName,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: SingleChildScrollView(
                          child: DataTable(columns: [
                            DataColumn(label: Text('Position')),
                            DataColumn(label: Text('')),
                          ], rows: _rowList),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: _addRow, child: Text('Add position')),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    rows = [];
                  });
                  List<DataCell> cells = [];
                  List companies = await readCsv(path);
                  for (String company in companies) {
                    for (TextEditingController controller in _controllerList) {
                      print('WORK IN PROCESS');
                      print(company);
                      print(controller.text);
                      print(script);
                      var result = await Process.run("python",
                          [script, company.toString(), controller.text]);
                      if (result.exitCode != 0) {
                        print("Erorr en bard");
                        print(result.stderr);
                      } else {
                        print('DONE');
                        print(result.stdout.toString());
                      }
                      List<String> answer = [
                        company,
                        controller.text,
                        result.exitCode.toString()
                      ];
                      cells.add(DataCell(Text(answer[0])));
                      cells.add(DataCell(Text(answer[1])));
                      cells.add(DataCell(Text(answer[2])));
                      rows.add(DataRow(cells: cells));
                      cells = [];
                    }
                    setState(() {
                      rows;
                    });
                  }
                },
                child: Text('Submit')),
            DataTable(columns: [
              DataColumn(label: Text('Company')),
              DataColumn(label: Text('Position')),
              DataColumn(label: Text('Search')),
            ], rows: rows),
          ],
        ),
      ),
    );
  }
}
