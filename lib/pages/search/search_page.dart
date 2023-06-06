import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/db/sqlite_service.dart';
import 'package:project/models/connection.dart';
import 'package:project/models/saved_search.dart';
import 'package:project/service/http/user.dart';
import 'package:project/service/json_service.dart';
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
  TextEditingController connectedOnController = TextEditingController();
  TextEditingController searchName = TextEditingController();
  TextEditingController searchNote = TextEditingController();

  List<Connection>? listData = [];
  DataTableSource _searchTable = SearchTable([]);
  List<List<dynamic>> head = [];
  bool valuefirst = false;
  late Future conn;
  List<bool> disable = [true, true, true, true, true, true];

  Future<void> allConnections() async {
    conn = connections();
    await conn.then((value) {
      listData = value;
    });
    setState(() {
      _searchTable = SearchTable(listData!);
    });
  }

  independentSearch() {
    if (valuefirst == true) {
      if (firstnameController.text.isNotEmpty) {
        setState(() {
          disable = [true, false, false, false, false, false];
        });
      }
      if (lastnameController.text.isNotEmpty) {
        setState(() {
          disable = [false, true, false, false, false, false];
        });
      }
      if (emailController.text.isNotEmpty) {
        setState(() {
          disable = [false, false, true, false, false, false];
        });
      }
      if (companyController.text.isNotEmpty) {
        setState(() {
          disable = [false, false, false, true, false, false];
        });
      }
      if (positionController.text.isNotEmpty) {
        setState(() {
          disable = [false, false, false, false, true, false];
        });
      }
      if (connectedOnController.text.isNotEmpty) {
        setState(() {
          disable = [false, false, false, false, false, true];
        });
      }
    }
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
                      decoration: const InputDecoration(hintText: 'Name'),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: searchNote,
                      decoration: const InputDecoration(hintText: 'Note'),
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
                onPressed: () async {
                  List<SavedSearch> searches = [];
                  Directory currentDir = Directory.current;
                  var jsonResponse = await JsonService().readJson(
                      '${currentDir.path}/assets/json/saved_search.json');
                  if (jsonResponse != []) {
                    for (var search in jsonResponse) {
                      searches.add(SavedSearch(
                          search['name'],
                          search['note'],
                          Connection(
                              search['connection']['first_name'],
                              search['connection']['last_name'],
                              search['connection']['email'],
                              search['connection']['company'],
                              search['connection']['position'],
                              search['connection']['connection'])));
                    }
                  }

                  searches.add(SavedSearch(
                      searchName.text,
                      searchNote.text,
                      Connection(
                          firstnameController.text,
                          lastnameController.text,
                          emailController.text,
                          companyController.text,
                          positionController.text,
                          connectedOnController.text)));
                  JsonService().updateJson(
                      '${currentDir.path}/assets/json/saved_search.json',
                      searches);

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
    allConnections();
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
                    'Search Contacts',
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
                            enabled: disable[0],
                            controller: firstnameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Firstname'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            enabled: disable[1],
                            controller: lastnameController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Lastname'),
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
                            enabled: disable[2],
                            controller: emailController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            enabled: disable[3],
                            controller: companyController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Company'),
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
                            enabled: disable[4],
                            controller: positionController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Position'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            enabled: disable[5],
                            controller: connectedOnController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Connected On'),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101));
                              String date =
                                  DateFormat('d-MMM-yy').format(pickedDate!);
                              setState(() {
                                connectedOnController.text = date;
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
                            print(value!);
                            valuefirst = value!;
                            independentSearch();
                            if (valuefirst == false) {
                              disable = [true, true, true, true, true, true];
                              firstnameController.text = "";
                              lastnameController.text = "";
                              emailController.text = "";
                              companyController.text = "";
                              positionController.text = "";
                              connectedOnController.text = "";
                            }
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
                    'Company Analysis',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PaginatedDataTable(
                    source: _searchTable,
                    columns: [
                      DataColumn(label: Text('First Name')),
                      DataColumn(label: Text('Last Name')),
                      DataColumn(label: Text('Email Address')),
                      DataColumn(label: Text('Company')),
                      DataColumn(label: Text('Position')),
                      DataColumn(label: Text('Connected On')),
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
  late List<Connection> listData;

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
      DataCell(Text(listData[index].firstname.toString())),
      DataCell(Text(listData[index].lastname)),
      DataCell(Text(listData[index].email.toString())),
      DataCell(Text(listData[index].company.toString())),
      DataCell(Text(listData[index].position.toString())),
      DataCell(Text(listData[index].connection.toString())),
    ]);
  }
}
