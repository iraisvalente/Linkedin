import 'dart:io';

import 'package:project/db/encrypt.dart';
import 'package:project/models/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class SqliteService {
  Future<Database> initDb() async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;

    if (await File('${Directory.current.path}/LinkedIn/linkedin.db').exists()) {
      File('${Directory.current.path}/LinkedIn/linkedin.db').create();
    }

    var db = await databaseFactory
        .openDatabase('${Directory.current.path}/LinkedIn/linkedin.db');

    db.execute('''
        CREATE TABLE IF NOT EXISTS USER (
          id         INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name  TEXT NOT NULL,
          email      TEXT NOT NULL,
          company    TEXT NOT NULL,
          position   INT  NOT NULL,
          password   TEXT NOT NULL
        )
      ''');

    return db;
  }

  Future<String> createUser(User user) async {
    late String response;
    Database db = await initDb();
    user.password = EncryptData.encryptAES(user.password);
    await db.insert('USER', user.toMap()).then((value) {
      response = value.toString();
    });
    await db.close();
    return response;
  }

  Future<User> login(String username, String password) async {
    Database db = await initDb();
    password = EncryptData.encryptAES(password);
    List<Map<String, Object?>> result = await db.query('USER',
        where: 'email="$username" and password="$password"');
    User user = User.login(result[0]['email'].toString());
    await db.close();
    return user;
  }
}
