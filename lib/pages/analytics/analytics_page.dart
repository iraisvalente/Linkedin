import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/models/company.dart';
import 'package:project/models/position.dart';
import 'package:project/service/http/analytics.dart';
import 'package:project/widgets/navbar_inside.dart';

class AnalyticsPage extends StatefulWidget {
  AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final DataTableSource _dataCompanyAnalytics = CompanyAnalyticsTable();
  final DataTableSource _dataContactsTable = ContactsTable();
  List<Position>? listPositions = [];
  List<Company>? listCompanies = [];

  Future<void> commonPositions() async {
    await positions(false).then((value) {
      setState(() {
        listPositions = [];
        listPositions = value;
        print(listPositions!.length);
      });
    });
  }

  Future<void> commonCompanies() async {
    await companies(false).then((value) {
      setState(() {
        listCompanies = [];
        listCompanies = value;
      });
    });
  }

  List<DataColumn> columns() {
    List<DataColumn> columns = [];
    columns.add(DataColumn(label: Text("Company")));
    for (int i = 0; i < listPositions!.length; i++) {
      columns.add(
        DataColumn(label: Text(listPositions![i].position)),
      );
    }
    return columns;
  }

  @override
  void initState() {
    super.initState();
    commonPositions();
    commonCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const NavBar(),
            Container(
              margin: const EdgeInsets.all(35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company Analysis",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PaginatedDataTable(
                    source: _dataCompanyAnalytics,
                    columns: columns(),
                    columnSpacing: 100,
                    horizontalMargin: 10,
                    rowsPerPage: 8,
                    showCheckboxColumn: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Contacts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PaginatedDataTable(
                    source: _dataContactsTable,
                    columns: const [
                      DataColumn(label: Text('FIRST NAME')),
                      DataColumn(label: Text('LAST NAME')),
                      DataColumn(label: Text('COMPANY')),
                      DataColumn(label: Text('POSITION')),
                      DataColumn(label: Text('SOA CONNECTIONS')),
                    ],
                    columnSpacing: 100,
                    horizontalMargin: 10,
                    rowsPerPage: 8,
                    showCheckboxColumn: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CompanyAnalyticsTable extends DataTableSource {
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => 0;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: []);
  }
}

class ContactsTable extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      20,
      (index) => {
            'firstname': 'Stephen',
            'lastname': 'Sebastian, CPA',
            'company': 'Immuneering Corporation',
            'position': 'Serior Director, Corporate Controller',
            'soa_connections': 'Joe Lyon',
          });

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['firstname'].toString())),
      DataCell(Text(_data[index]['lastname'])),
      DataCell(Text(_data[index]['company'].toString())),
      DataCell(Text(_data[index]['position'].toString())),
      DataCell(Text(_data[index]['soa_connections'].toString())),
    ]);
  }
}
