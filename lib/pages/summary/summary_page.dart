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

  List<Position>? listPosotions = [];
  List<Connection>? listConnections = [];
  List<Company>? listCompanies = [];

  Future<void> commonPositions() async {
    await positions().then((value) {
      setState(() {
        listPosotions = [];
        listPosotions = value;
      });
    });
  }

  Future<void> commonCompanies() async {
    await companies().then((value) {
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
    for (int i = 0; i < listPosotions!.length; i++) {
      rows.add(DataRow(cells: [
        DataCell(Text(listPosotions![i].position)),
        DataCell(Text(listPosotions![i].count.toString())),
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
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade400, spreadRadius: 2),
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
                                  label: Text('AVG CONNECTIONS PER SOA'),
                                ),
                                DataColumn(
                                  label: Text('AVG UNIQUE COMPANIES PER SOA'),
                                ),
                                DataColumn(
                                  label: Text('% OVERLAPPING COMPANIES'),
                                ),
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
                                  label: Text('CONTACTS ADDED (ALST 30 DAYS)'),
                                ),
                              ], rows: [
                                DataRow(cells: [
                                  DataCell(Text("118.50")),
                                  DataCell(Text("81.00")),
                                  DataCell(Text("99.00%")),
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
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade400, spreadRadius: 2),
                      ],
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      controller: controllerCompanyAnalytics,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: controllerCompanyAnalytics,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: TextFormField(
                                        controller: companyController,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Company"),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your lastname';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors.grey.shade400;
                                        }
                                        return Colors.grey.shade300;
                                      }),
                                      foregroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors.white;
                                        }
                                        return Colors.black54;
                                      }),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Search'),
                                  )),
                                ],
                              ),
                              Container(
                                height: 35,
                                child: Center(
                                    child: Text(
                                  'Company Analytics Summary',
                                  style: TextStyle(color: Colors.black54),
                                )),
                              ),
                              DataTable(columns: [
                                DataColumn(
                                  label: Text('AVG CONNECTIONS PER SOA'),
                                ),
                                DataColumn(
                                  label: Text('AVG UNIQUE COMPANIES PER SOA'),
                                ),
                                DataColumn(
                                  label: Text('UNIQUE NAMES'),
                                ),
                                DataColumn(
                                  label: Text('UNIQUE POSITIONS'),
                                ),
                                DataColumn(
                                  label: Text('CONTACTS ADDED (ALST 30 DAYS)'),
                                ),
                              ], rows: [
                                DataRow(cells: [
                                  DataCell(Text("4.0")),
                                  DataCell(Text("4.00")),
                                  DataCell(Text("4")),
                                  DataCell(Text("4")),
                                  DataCell(Text("4")),
                                ]),
                              ]),
                            ],
                          )),
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
