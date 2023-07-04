import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:project/models/file_request.dart';
import 'package:project/models/linked_result.dart';
import 'package:project/service/http/linked.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';

class ImportContactSearchPage extends StatefulWidget {
  const ImportContactSearchPage({super.key});

  @override
  State<ImportContactSearchPage> createState() =>
      _ImportContactSearchPageState();
}

class _ImportContactSearchPageState extends State<ImportContactSearchPage> {
  String fileName = "No file chosen";
  String fileContent = "";
  String conecction = "";
  LinkedService linkedService = LinkedService();

  void getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    conecction = prefs.getString('email')!;
  }

  @override
  void initState() {
    super.initState();
    getCredentials();
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
                    "Import Contacts",
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
                    onPressed: () {
                      html.FileUploadInputElement uploadInput =
                          html.FileUploadInputElement();
                      uploadInput.multiple = false;
                      uploadInput.accept = 'text/csv';
                      uploadInput.onChange.listen((event) {
                        html.File file = uploadInput.files!.first;
                        html.FileReader reader = html.FileReader();
                        reader.readAsText(file);
                        reader.onLoadEnd.listen((event) {
                          String fileContent = reader.result as String;
                          List<List<dynamic>> csvData =
                              CsvToListConverter().convert(fileContent);
                          fileContent = csvData
                              .map((innerList) => innerList
                                  .map((element) => element
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', ''))
                                  .join(', '))
                              .join('\n');
                          setState(() {
                            fileName = file.name; // Set the fileName directly
                          });
                        });
                      });
                      html.document.body?.append(uploadInput);
                      uploadInput.click();
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
                      LinkedResult? result = await linkedService.uploadFile(
                          FileRequest(fileName, fileContent, conecction));
                      print(result!.result);
                      if (result!.result == 'Copied') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('File imported successfully')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('File import failed')),
                        );
                      }
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
