import 'dart:io';

import 'package:flutter/material.dart';
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
                        path= picked.files.first.path.toString();
                        fileName = picked.files.first.name;
                        setState(() {
                          fileName=fileName;
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
            )
          ],
        ),
      ),
    );
  }
}
