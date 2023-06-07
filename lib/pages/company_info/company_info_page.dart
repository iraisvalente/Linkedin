import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  final DataTableSource _dataContactsTable = ContactsTable();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
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
      ),
    );
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
