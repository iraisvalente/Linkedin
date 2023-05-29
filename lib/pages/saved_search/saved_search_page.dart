import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';

class SavedSearchPage extends StatelessWidget {
  const SavedSearchPage({super.key});

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
                      ], rows: [
                        DataRow(cells: [
                          DataCell(Text("Example")),
                          DataCell(Text("This is an example")),
                          DataCell(Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Re-run search")),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
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
                                  child: Text("Delete"))
                            ],
                          )),
                        ]),
                      ]),
                    ),
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
