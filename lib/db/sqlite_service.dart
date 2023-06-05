import 'dart:io';
import 'dart:math';

import 'package:mysql_client/mysql_client.dart';
import 'package:project/db/encrypt.dart';
import 'package:project/models/user.dart';
import 'package:mysql_manager/src/mysql_manager.dart';

class SqliteService {
  /*
  Future<void> createUser(User user) async {
    final MySQLManager manager = MySQLManager.instance;
    final conn = await manager.init();
    final results = await conn.execute('select * from users');
  }*/
  Future<void> initDb() async {}

  Future<BigInt> createUser(User user) async {
    print("Connecting to mysql server...");

    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: "root",
      password: "password",
      databaseName: "linkedin",
    );

    print(conn);

    await conn.connect();

    print("Connected");

    user.password = EncryptData.encryptAES(user.password);

    var res = await conn.execute(
      'INSERT INTO users (First_Name, Last_Name, Email_Address, Company,' +
          'Position, Password_user) values ("${user.firstname}", "${user.lastname}", ' +
          '"${user.email}", "${user.company}", "${user.position}", "${user.password}");',
    );

    print(res.affectedRows);

    await conn.close();
    return res.affectedRows;
  }

  Future<User?> login(String email, String password) async {
    User? user = null;
    print("Connecting to mysql server...");

    final conn = await MySQLConnection.createConnection(
      host: "127.0.0.1",
      port: 3306,
      userName: "root",
      password: "password",
      databaseName: "linkedin",
    );

    print("conn");

    await conn.connect();
    password = EncryptData.encryptAES(password);
    print(
        'SELECT * FROM users WHERE Email_Address = "$email" AND Password_user = "$password")');
    var res = await conn.execute(
        'SELECT * FROM users WHERE Email_Address = "$email" AND Password_user = "$password"');
    for (final row in res.rows) {
      user = User.login(row.assoc()['Email_Address']!);
    }
    print(user?.email);
    await conn.close();
    return user;
  }

  /*
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
  }*/
}
