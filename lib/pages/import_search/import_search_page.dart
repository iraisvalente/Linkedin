import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:project/models/connection.dart';
import 'package:project/models/saved_search.dart';
import 'package:project/service/json_service.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'package:file_picker/file_picker.dart';

class ImportSearchPage extends StatefulWidget {
  const ImportSearchPage({super.key});

  @override
  State<ImportSearchPage> createState() => _ImportSearchPageState();
}

class _ImportSearchPageState extends State<ImportSearchPage> {
  String fileName = "No file chosen";
  String path = "";
  List<List<dynamic>> data = [];
  List<SavedSearch> searches = [];
  Directory currentDir = Directory.current;

  Future readCsv(String path) async {
    final File file = File(path);
    String contents = await file.readAsString();
    return const CsvToListConverter().convert(contents, eol: "\n");
  }

  readSearches() async {
    var jsonResponse = await JsonService()
        .readJson('${currentDir.path}/assets/json/saved_search.json');
    if (jsonResponse != []) {
      for (var search in jsonResponse) {
        searches.add(SavedSearch(
            search['name'],
            search['note'],
            search['search'],
            Connection(
                search['connection']['first_name'],
                search['connection']['last_name'],
                search['connection']['email'],
                search['connection']['company'],
                search['connection']['position'],
                search['connection']['connection'])));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(),
            Container(
              margin: EdgeInsets.only(bottom: 35, top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Import Search",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
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
                      data = await readCsv(path);
                      data.removeAt(0);
                      for (List<dynamic> search in data) {
                        searches.add(SavedSearch(
                            search[0],
                            search[1],
                            (search[2] == "FALSE" || search[2] == "false")
                                ? false
                                : true,
                            Connection(search[3], search[4], search[5],
                                search[6], search[7], search[8])));
                      }
                      JsonService().updateJson(
                          '${currentDir.path}/assets/json/saved_search.json',
                          searches);
                    },
                    child: const Text('Import'),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
