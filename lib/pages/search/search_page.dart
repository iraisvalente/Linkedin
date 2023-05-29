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
  TextEditingController searchName = TextEditingController();
  TextEditingController searchNote = TextEditingController();
  String? codeDialog;
  String? valueText;
  String dropdownvalue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

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
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
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
                              const SnackBar(
                                  content: Text('Please fill input')),
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
                  ),
                  SizedBox(height: 20),
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
                        SizedBox(width: 35),
                        SizedBox(
                            child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Export selected'),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
