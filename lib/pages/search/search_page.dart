import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController searchName = TextEditingController();
  TextEditingController searchNote = TextEditingController();

  Directory currentDir = Directory.current;
  List<List<dynamic>> listData = [];
  DataTableSource _searchTable = SearchTable([]);
  List<List<dynamic>> head = [];
  bool valuefirst = false;

  Future readCsv() async {
    final File file = File(
        '${currentDir.path}/LinkedIn/unzip/Basic_LinkedInDataExport_04-25-2023/Connections.csv');
    String contents = await file.readAsString();
    setState(() {
      listData = const CsvToListConverter().convert(contents);
      head = [listData[0]];
      _searchTable = SearchTable(listData..removeAt(0));
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Toggle search save'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.20,
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchName,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: searchNote,
                      decoration: const InputDecoration(hintText: "Note"),
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    searchName.text = '';
                    searchNote.text = '';
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    searchName.text = '';
                    searchNote.text = '';
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    print('listData');
    print(listData);
    readCsv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            Container(
              margin: EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search Contacts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: firstnameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Firstname"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: lastnameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Lastname"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: companyController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Company"),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: positionController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Position"),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: dateController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Connected On"),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now(), //get today's date
                                  firstDate: DateTime
                                      .now(), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));
                              setState(() {
                                dateController.text = pickedDate.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Independent search by field: ',
                        style: TextStyle(fontSize: 17.0),
                      ),
                      Checkbox(
                        value: valuefirst,
                        onChanged: (value) {
                          setState(() {
                            valuefirst = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: ElevatedButton(
                        onPressed: () async {},
                        child: const Text('Search'),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Company Analysis",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PaginatedDataTable(
                    source: _searchTable,
                    columns: [
                      DataColumn(label: Text(head[0][0])),
                      DataColumn(label: Text(head[0][1])),
                      DataColumn(label: Text(head[0][2])),
                      DataColumn(label: Text(head[0][3])),
                      DataColumn(label: Text(head[0][4])),
                      DataColumn(label: Text(head[0][5])),
                    ],
                    columnSpacing: 100,
                    horizontalMargin: 10,
                    rowsPerPage: 8,
                    showCheckboxColumn: false,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35, right: 35),
              child: Row(
                children: [
                  SizedBox(
                      child: ElevatedButton(
                    onPressed: () {
                      _displayTextInputDialog(context);
                    },
                    child: const Text('Toggle save search'),
                  )),
                  SizedBox(width: 10),
                  SizedBox(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Export selected'),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class SearchTable extends DataTableSource {
  late List<List<dynamic>> listData;

  SearchTable(this.listData);

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => listData.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(listData[index][0].toString())),
      DataCell(Text(listData[index][1])),
      DataCell(Text(listData[index][2].toString())),
      DataCell(Text(listData[index][3].toString())),
      DataCell(Text(listData[index][4].toString())),
      DataCell(Text(listData[index][5].toString())),
    ]);
  }
}
