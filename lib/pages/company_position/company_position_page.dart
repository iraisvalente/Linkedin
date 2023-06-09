import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'package:file_picker/file_picker.dart';

class CompanyPositionPage extends StatefulWidget {
  const CompanyPositionPage({super.key});

  @override
  State<CompanyPositionPage> createState() => _CompanyPositionPageState();
}

class _CompanyPositionPageState extends State<CompanyPositionPage> {
  String fileName = "No file chosen";
  String path = "";

  List<DataRow> _rowList = [];
  List<String> _positions = [];

  void _addRow() {
    setState(() {
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(
            TextFormField(
              initialValue: '',
              keyboardType: TextInputType.text,
              onFieldSubmitted: (val) {
                print('onSubmited $val');
                _positions.add(val);
              },
            ),
            showEditIcon: true)
      ]));
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
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.20,
                  right: MediaQuery.of(context).size.width * 0.20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Import company position",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Select  CSV or Excel file",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.grey.shade400;
                            }
                            return Colors.grey.shade300;
                          }),
                          foregroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white;
                            }
                            return Colors.black54;
                          }),
                        ),
                        onPressed: () async {
                          var picked = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'csv',
                                'xlsx',
                                'xlsm',
                                'xlsb',
                                'xltx'
                              ]);
                          if (picked != null) {
                            path = picked.files.first.path.toString();
                            fileName = picked.files.first.name;
                            setState(() {
                              fileName = fileName;
                            });
                          }
                        },
                        child: const Text('Choose File'),
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        fileName,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                          child: ElevatedButton(
                        onPressed: () async {
                          //var  result = await Process.run("python", ["C:\\Users\\artur\\Projects\\LinkedIn\\linked.py","Copy",fileName]);
                          //print(fileName);
                          //print(result.stdout);
                        },
                        child: const Text('Import'),
                      )),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Container(
                        child: DataTable(columns: [
                          DataColumn(label: Text('Position')),
                        ], rows: _rowList),
                      ),
                      ElevatedButton(
                          onPressed: _addRow, child: Text('Add position')),
                    ],
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
