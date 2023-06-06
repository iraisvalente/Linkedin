import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/connection.dart';
import 'package:project/models/user.dart';

Future<http.Response?> login(String email, String password) async {
  return http.post(
    Uri.parse('http://127.0.0.1:8000/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Email_Address': email,
      'Password_user': password,
    }),
  );
}

Future<http.Response?> register(User user) async {
  print(user.toMap());
  return http.post(
    Uri.parse('http://127.0.0.1:8000/users/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toMap()),
  );
}

Future<List<Connection>?> connections() async {
  List<Connection>? connections = [];
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/connections/'));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    for (final response in responseJson) {
      connections.add(Connection(
          response['First_Name']!,
          response['Last_Name']!,
          response['Email_Address']!,
          response['Company']!,
          response['Position']!,
          response['Connection']!));
    }
    print(connections.length);
    return connections;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Connection>?> connectionsFilter(String filter, String value) async {
  List<Connection>? connections = [];
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/connections/$filter/$value'));

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    for (final response in responseJson) {
      connections.add(Connection(
          response['First_Name']!,
          response['Last_Name']!,
          response['Email_Address']!,
          response['Company']!,
          response['Position']!,
          response['Connection']!));
    }
    print(connections.length);
    return connections;
  } else {
    throw Exception('Failed to load album');
  }
}
