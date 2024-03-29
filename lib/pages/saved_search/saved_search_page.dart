import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/models/connection.dart';
import 'package:project/models/saved_search.dart';
import 'package:project/pages/search/search_page.dart';
import 'package:project/service/json_service.dart';
import 'package:project/widgets/navbar_inside.dart';

class SavedSearchPage extends StatefulWidget {
  const SavedSearchPage({super.key});

  @override
  State<SavedSearchPage> createState() => _SavedSearchPageState();
}

class _SavedSearchPageState extends State<SavedSearchPage> {
  List<SavedSearch> searches = [];
  Directory currentDir = Directory.current;
  readSearches() async {
    Directory currentDir = Directory.current;
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
    setState(() {
      rows();
    });
  }

  List<DataRow> rows() {
    List<DataRow> row = [];
    for (int i = 0; i < searches.length; i++) {
      row.add(DataRow(cells: [
        DataCell(Text(searches[i].name)),
        DataCell(Text(searches[i].note)),
        DataCell(Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => SearchPage(
                          name: searches[i].name,
                          note: searches[i].note,
                          search: searches[i].search,
                          connection: searches[i].connection),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
                child: Text("Re-run search")),
            SizedBox(
              width: 30,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.grey.shade400;
                    }
                    return Colors.grey.shade300;
                  }),
                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white;
                    }
                    return Colors.black54;
                  }),
                ),
                onPressed: () {
                  searches.remove(searches[i]);
                  setState(() {
                    JsonService().updateJson(
                        '${currentDir.path}/assets/json/saved_search.json',
                        searches);
                  });
                },
                child: Text("Delete"))
          ],
        )),
      ]));
    }
    return row;
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
                    "Saved Searches",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: DataTable(columns: [
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Note'),
                          ),
                          DataColumn(label: Text('Action')),
                        ], rows: rows())),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
