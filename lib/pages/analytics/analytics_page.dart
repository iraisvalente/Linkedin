import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class AnalyticsPage extends StatelessWidget {
  AnalyticsPage({super.key});
  final DataTableSource _dataCompanyAnalytics = CompanyAnalyticsTable();
  final DataTableSource _dataContactsTable = ContactsTable();

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
                    "Company Analysis",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  PaginatedDataTable(
                    source: _dataCompanyAnalytics,
                    columns: const [
                      DataColumn(label: Text('Company')),
                      DataColumn(label: Text('BOD')),
                      DataColumn(label: Text('CFO')),
                      DataColumn(label: Text('CAD')),
                      DataColumn(label: Text('CONTROLLER')),
                      DataColumn(label: Text('SEC')),
                      DataColumn(label: Text('REPORTING')),
                      DataColumn(label: Text('INTERNAL AUDIT')),
                      DataColumn(label: Text('ACCOUNTING')),
                      DataColumn(label: Text('FINANCE')),
                    ],
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
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      20,
      (index) => {
            'company': 'company',
            'bod': '0',
            'cfo': '0',
            'cad': '0',
            'controller': '0',
            'sec': '0',
            'reporting': '0',
            'internal audit': '0',
            'accounting': '0',
            'finance': '0',
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
      DataCell(Text(_data[index]['company'].toString())),
      DataCell(Text(_data[index]['bod'])),
      DataCell(Text(_data[index]['cfo'].toString())),
      DataCell(Text(_data[index]['cad'].toString())),
      DataCell(Text(_data[index]['controller'].toString())),
      DataCell(Text(_data[index]['sec'].toString())),
      DataCell(Text(_data[index]['reporting'].toString())),
      DataCell(Text(_data[index]['internal audit'].toString())),
      DataCell(Text(_data[index]['accounting'].toString())),
      DataCell(Text(_data[index]['finance'].toString())),
    ]);
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
