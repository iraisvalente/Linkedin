import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class SummaryPage extends StatelessWidget {
  SummaryPage({super.key});

  ScrollController controllerAnalyticsSummary = ScrollController();
  ScrollController controllerCompanyAnalytics = ScrollController();
  TextEditingController companyController = TextEditingController();

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
                        height: MediaQuery.of(context).size.height * 0.30,
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
                              DataTable(columns: [
                                DataColumn(
                                  label: Text('Position'),
                                ),
                                DataColumn(
                                  label: Text('Count'),
                                ),
                              ], rows: [
                                DataRow(cells: [
                                  DataCell(Text("Director")),
                                  DataCell(Text("15")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Partner")),
                                  DataCell(Text("10")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Principal")),
                                  DataCell(Text("9")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("CFO")),
                                  DataCell(Text("8")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Internal Audit")),
                                  DataCell(Text("7")),
                                ]),
                              ]),
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.30,
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
                              DataTable(columns: [
                                DataColumn(
                                  label: Text('Company'),
                                ),
                                DataColumn(
                                  label: Text('Count'),
                                ),
                              ], rows: [
                                DataRow(cells: [
                                  DataCell(Text("Google")),
                                  DataCell(Text("40")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("SOAProjects, Inc")),
                                  DataCell(Text("35")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("EY")),
                                  DataCell(Text("34")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("BOK Financial")),
                                  DataCell(Text("30")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Twitter")),
                                  DataCell(Text("28")),
                                ]),
                              ]),
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.30,
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
                              DataTable(columns: [
                                DataColumn(
                                  label: Text('SOA Connection'),
                                ),
                                DataColumn(
                                  label: Text('Count'),
                                ),
                              ], rows: [
                                DataRow(cells: [
                                  DataCell(Text("Daniel Robert")),
                                  DataCell(Text("3")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Miguel Martin")),
                                  DataCell(Text("1")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Sheldon Stone")),
                                  DataCell(Text("5")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Leonard Allen")),
                                  DataCell(Text("1")),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text("Roger Cooper")),
                                  DataCell(Text("4")),
                                ]),
                              ]),
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
