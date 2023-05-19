import 'package:flutter/widgets.dart';
import 'package:project/db/encrypt.dart';
import 'package:project/models/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<Database> initDb() async {
    sqfliteFfiInit();

    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase('C:\\Project.db');

    databaseFactory.databaseExists('C:\\Project.db');

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
    print(user);
    return user;
  }
}
