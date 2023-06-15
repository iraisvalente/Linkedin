import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/models/connection.dart';
import 'package:project/service/http/connection.dart';
import 'package:project/service/json_service.dart';
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

  List<dynamic> bardResult = [];
  List<DataRow> _rowList = [];
  List<DataRow> rows = [];
  List<String> positions = [];
  List<TextEditingController> _controllerList = [];
  List<List<String>> _answerContent = [];
  List<Connection>? listData = [];
  List<Column> tables = [];

  Future<List<String>> readCsv(String path) async {
    final File file = File(path);
    String contents = await file.readAsString();
    List<String> lines = contents.split('\n');
    lines.removeLast();
    return lines;
  }

  Future<List<Connection>> connections(String company) async {
    List<Connection> connections = [];
    await searchConnection(company).then((value) {
      print(value);
      connections = [];
      connections = value!;
    });
    return connections;
  }

  List<DataColumn> columns() {
    return [
      DataColumn(label: Text('Firstname')),
      DataColumn(label: Text('Lastname')),
      DataColumn(label: Text('Email Addres')),
      DataColumn(label: Text('Company')),
      DataColumn(label: Text('Position'))
    ];
  }

  Column table(DataTableSource table) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(30),
          child: PaginatedDataTable(
            source: table,
            columns: columns(),
            columnSpacing: 100,
            horizontalMargin: 10,
            rowsPerPage: 5,
            showCheckboxColumn: false,
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  void _addRow(String? position) {
    if (position == null) {
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
    } else {
      int index = _rowList.length;
      TextEditingController controller = TextEditingController(text: position);
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
  }

  void _deleteRow(int index) {
    _rowList.removeAt(index);
    _controllerList.removeAt(index);
    setState(() {
      print(index);
      _rowList;
      _controllerList;
    });
  }

  void readPosition() async {
    var jsonResponse = await JsonService()
        .readJson('${current.path}/assets/json/positions.json');
    if (jsonResponse != []) {
      for (var position in jsonResponse) {
        positions.add(position['position']);
      }
    }
    if (positions.isNotEmpty) {
      print(positions.length);
      for (String position in positions) {
        _addRow(position);
      }
    }
  }

  void updatePosition() async {
    List<Map> positionsMap = [];
    for (String position in positions) {
      positionsMap.add({"position": position});
    }
    JsonService()
        .updateJson('${current.path}/assets/json/positions.json', positionsMap);
  }

  @override
  void initState() {
    super.initState();
    readPosition();
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
                          onPressed: () => _addRow(null),
                          child: Text('Add position')),
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
                      var comp = company
                          .toString()
                          .toUpperCase()
                          .replaceAll("\n", " ");
                      comp = comp.toString().toUpperCase().replaceAll(" ", "");
                      comp = comp.toString().toUpperCase().replaceAll('"', "");
                      comp = comp.trim();
                      var pos = controller.text.toString().toUpperCase();
                      print(comp);
                      print(pos);
                      print(script);
                      var result =
                          await Process.run("python", [script, comp, pos]);
                      if (result.exitCode != 0) {
                        print("Erorr en bard");
                        print(result.stderr);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Search failed')),
                        );
                      } else {
                        print('DONE');
                        print(result.stdout.toString());
                        print(result.stdout.runtimeType);
                        bardResult.add(result.stdout);
                        for (var result in bardResult) {
                          var personName;
                          print('RESULTADO');
                          personName = result.split(".")[0].toString();
                          print(personName);
                          List<dynamic> listResume =
                              result.split(".").sublist(1);
                          print(listResume);
                          String resume = listResume.join(' ');
                          print(resume);
                          try {
                            String linkedinLink =
                                'https://www${listResume[listResume.length - 2]}.${listResume.last}';
                            print(linkedinLink);
                            if (resume.contains(personName)) {
                              print('encontrado');
                              List<String> answer = [
                                company,
                                controller.text,
                                personName,
                                resume,
                                linkedinLink
                              ];
                              cells.add(DataCell(Text(answer[0])));
                              cells.add(DataCell(Text(answer[1])));
                              cells.add(DataCell(Text(answer[2])));
                              cells.add(DataCell(Text(answer[3])));
                              cells.add(DataCell(Text(answer[4])));
                              rows.add(DataRow(cells: cells));
                            } else {
                              print('no encontrado');
                              List<String> answer = [
                                company,
                                controller.text,
                                '',
                                '',
                                ''
                              ];
                              cells.add(DataCell(Text(answer[0])));
                              cells.add(DataCell(Text(answer[1])));
                              cells.add(DataCell(Text(answer[2])));
                              cells.add(DataCell(Text(answer[3])));
                              cells.add(DataCell(Text(answer[4])));
                              rows.add(DataRow(cells: cells));
                            }
                          } catch (e) {
                            List<String> answer = [
                              company,
                              controller.text,
                              personName,
                              resume,
                              ''
                            ];
                            cells.add(DataCell(Text(answer[0])));
                            cells.add(DataCell(Text(answer[1])));
                            cells.add(DataCell(Text(answer[2])));
                            cells.add(DataCell(Text(answer[3])));
                            cells.add(DataCell(Text(answer[4])));
                            rows.add(DataRow(cells: cells));
                          }

                          cells = [];
                        }
                        bardResult = [];
                        print(bardResult);
                      }
                      setState(() {
                        rows;
                      });
                      tables = [];
                      List<String> companies = await readCsv(path);
                      for (String company in companies) {
                        var comp = company
                            .toString()
                            .toUpperCase()
                            .replaceAll("\n", " ");
                        comp =
                            comp.toString().toUpperCase().replaceAll(" ", "");
                        comp =
                            comp.toString().toUpperCase().replaceAll('"', "");
                        comp = comp.trim();
                        List<Connection> conn = await connections(comp);
                        DataTableSource tableConnection =
                            ConnectionsTable(conn);
                        setState(() {
                          tables.add(table(tableConnection));
                        });
                      }
                    }
                  }
                  positions = [];
                  for (TextEditingController controller in _controllerList) {
                    positions.add(controller.text);
                  }
                  updatePosition();
                  updatePosition();
                },
                child: Text('Submit')),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: DataTable(columns: [
                DataColumn(label: Text('Company')),
                DataColumn(label: Text('Position')),
                DataColumn(label: Text('Person')),
                DataColumn(label: Text('Summary')),
                DataColumn(label: SelectableText('Link to LinkedIn')),
              ], rows: rows, dataRowHeight: 190),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: tables,
            )
          ],
        ),
      ),
    );
  }
}

class ConnectionsTable extends DataTableSource {
  final List<Connection> table;
  ConnectionsTable(this.table) {
    print('using table');
    print(this.table.length);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => table.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(table[index].firstname!)),
      DataCell(Text(table[index].lastname!)),
      DataCell(Text(table[index].email!)),
      DataCell(Text(table[index].company!)),
      DataCell(Text(table[index].position!))
    ]);
  }
}
