import 'package:project/models/connection.dart';

class SavedSearch {
  final String name;
  final String note;
  final Connection connection;

  SavedSearch(this.name, this.note, this.connection);

  SavedSearch.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        note = json['note'],
        connection = Connection.fromMap(json['connection']);

  Map<String, dynamic> toJson() {
    return {'name': name, 'note': note, 'connection': connection.toMap()};
  }
}
