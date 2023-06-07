import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/company.dart';
import 'package:project/models/connection.dart';
import 'package:project/models/position.dart';

Future<List<Connection>?> connections() async {
  List<Connection>? connections = [];
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/common_connections/'));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    print(responseJson);
    for (final response in responseJson) {
      connections.add(Connection.commonConnection(
          response['Connection']!, int.parse(response['Count']!)));
    }
    return connections;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Company>?> companies() async {
  List<Company>? companies = [];
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/common_companies/'));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    print(responseJson);
    for (final response in responseJson) {
      companies
          .add(Company(response['Company']!, int.parse(response['Count']!)));
    }
    return companies;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Position>?> positions() async {
  List<Position>? positions = [];
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/common_positions/'));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    for (final response in responseJson) {
      positions
          .add(Position(response['Position']!, int.parse(response['Count']!)));
    }
    return positions;
  } else {
    throw Exception('Failed to load album');
  }
}
