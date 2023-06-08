import 'package:flutter/material.dart';
import 'package:project/models/company.dart';
import 'package:project/models/connection.dart';
import 'package:project/models/position.dart';
import 'package:project/service/http/analytics.dart';
import 'package:project/widgets/navbar_inside.dart';

class SummaryPage extends StatefulWidget {
  SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  ScrollController controllerAnalyticsSummary = ScrollController();
  ScrollController controllerCompanyAnalytics = ScrollController();
  TextEditingController companyController = TextEditingController();

  List<Position>? listPositions = [];
  List<Connection>? listConnections = [];
  List<Company>? listCompanies = [];

  Future<void> commonPositions() async {
    await positions(true).then((value) {
      setState(() {
        listPositions = [];
        listPositions = value;
      });
    });
  }

  Future<void> commonCompanies() async {
    await companies(true).then((value) {
      setState(() {
        listCompanies = [];
        listCompanies = value;
      });
    });
  }

  Future<void> commonConnections() async {
    await connections().then((value) {
      setState(() {
        listConnections = [];
        listConnections = value;
      });
    });
  }

  Widget positionsTable() {
    List<DataRow> rows = [];
    for (int i = 0; i < listPositions!.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text(listPositions![i].position)),
        DataCell(Text(listPositions![i].count.toString())),
      ]));
    }

    return DataTable(columns: const [
      DataColumn(
        label: Text('SOA Connection'),
      ),
      DataColumn(
        label: Text('Count'),
      ),
    ], rows: rows);
  }

  Widget companiesTable() {
    List<DataRow> rows = [];
    for (int i = 0; i < listCompanies!.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text(listCompanies![i].company)),
        DataCell(Text(listCompanies![i].count.toString())),
      ]));
    }

    return DataTable(columns: const [
      DataColumn(
        label: Text('SOA Connection'),
      ),
      DataColumn(
        label: Text('Count'),
      ),
    ], rows: rows);
  }

  Widget connectionsTable() {
    List<DataRow> rows = [];
    for (int i = 0; i < listConnections!.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text(listConnections![i].connection)),
        DataCell(Text(listConnections![i].count.toString())),
      ]));
    }

    return DataTable(columns: const [
      DataColumn(
        label: Text('SOA Connection'),
      ),
      DataColumn(
        label: Text('Count'),
      ),
    ], rows: rows);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commonPositions();
    commonCompanies();
    commonConnections();
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
                    "Analytics Summary",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                child: Center(
                                    child: Text(
                                  'Top 5 Most Common Positions',
                                  style: TextStyle(color: Colors.black54),
                                )),
                              ),
                              positionsTable()
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                child: Center(
                                    child: Text(
                                  'Top 5 Most Common Companies',
                                  style: TextStyle(color: Colors.black54),
                                )),
                              ),
                              companiesTable()
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                child: Center(
                                    child: Text(
                                  'SOA Connections',
                                  style: TextStyle(color: Colors.black54),
                                )),
                              ),
                              connectionsTable()
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400, spreadRadius: 2),
                        ],
                      ),
                      child: Scrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: controllerAnalyticsSummary,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: controllerAnalyticsSummary,
                            child: Column(
                              children: [
                                Container(
                                  height: 35,
                                  child: Center(
                                      child: Text(
                                    'Analytics Summary',
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                                DataTable(columns: [
                                  DataColumn(
                                    label: Text('UNIQUE NAMES'),
                                  ),
                                  DataColumn(
                                    label: Text('UNIQUE COMPANIES'),
                                  ),
                                  DataColumn(
                                    label: Text('UNIQUE POSITIONS'),
                                  ),
                                  DataColumn(
                                    label:
                                        Text('CONTACTS ADDED (LAST 30 DAYS)'),
                                  ),
                                ], rows: [
                                  DataRow(cells: [
                                    DataCell(Text("466")),
                                    DataCell(Text("320")),
                                    DataCell(Text("426")),
                                    DataCell(Text("477")),
                                  ]),
                                ]),
                              ],
                            )),
                      ),
                    ),
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
