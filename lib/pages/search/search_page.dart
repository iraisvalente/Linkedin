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

  String dropdownvalue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your firstname';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your lastname';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your company';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your position';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            value: dropdownvalue,
                            isExpanded: true,
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
                child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {} catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'There was a problem adding a user, please try again')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill input')),
                  );
                }
              },
              child: const Text('Search'),
            )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: DataTable(columns: [
                DataColumn(
                  label: Text('First name'),
                ),
                DataColumn(
                  label: Text('Last name'),
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Company'),
                ),
                DataColumn(
                  label: Text('Position'),
                ),
                DataColumn(
                  label: Text('Count of connections'),
                ),
              ], rows: [
                DataRow(cells: [
                  DataCell(Text("Alex")),
                  DataCell(Text("Anderson")),
                  DataCell(Text("anderson_axle@email.com")),
                  DataCell(Text("Example")),
                  DataCell(Text("Dev")),
                  DataCell(Text("1")),
                ]),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
