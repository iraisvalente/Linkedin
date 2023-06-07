import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class ImportContactSearchPage extends StatefulWidget {
  const ImportContactSearchPage({super.key});

  @override
  State<ImportContactSearchPage> createState() =>
      _ImportContactSearchPageState();
}

class _ImportContactSearchPageState extends State<ImportContactSearchPage> {
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
                      //DateTime now = DateTime.now();
                      //String date = DateFormat.d().format(now) +
                      //    '-' +
                      //    DateFormat.M().format(now) +
                      //    '-' +
                      //    DateFormat.y().format(now);
                      //String hour = DateFormat.H().format(now) +
                      //    '-' +
                      //    DateFormat.m().format(now) +
                      //    '-' +
                      //    DateFormat.s().format(now);
                      //Directory currentDir = Directory.current;
                      //final Directory appDocDirFolder = Directory(
                      //    '${currentDir.path}/LinkedIn/${'$date-$hour'}');
                      //await appDocDirFolder.create(recursive: true);
                      //File('${appDocDirFolder.path}/$fileName')
                      //    .create(recursive: true);
                      var  result = await Process.run("python", ["C:\\Users\\artur\\Projects\\LinkedIn\\linked.py","Copy",path]);
                      print(fileName);
                      print(result.stdout);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('File imported successfully')),
                      );
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
