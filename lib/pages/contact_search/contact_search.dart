import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/models/linked.dart';
import 'package:project/models/linked_result.dart';
import 'package:project/service/http/linked.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImportContactSearchPage extends StatefulWidget {
  ImportContactSearchPage({super.key});

  @override
  State<ImportContactSearchPage> createState() =>
      _ImportContactSearchPageState();
}

class _ImportContactSearchPageState extends State<ImportContactSearchPage> {
  String fileName = "No file chosen";
  String path = "";
  Directory current = Directory.current;
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
    String script =
        current.absolute.uri.toString().split("file:///")[1] + "linked.py";

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
                        setState(() {
                          fileName = picked.files.first.name;
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
                      try {
                        LinkedResult? result = await linkedService.copy(path);
                        result = await linkedService
                            .append(Linked(conecction, null));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('File imported successfully')),
                        );
                      } catch (e) {
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
