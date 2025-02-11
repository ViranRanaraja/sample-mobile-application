// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  Database? _userDb;

  Future<Database> get db async {
    if (_userDb != null) {
      return _userDb!;
    }

    _userDb = await _initialize();
    return _userDb!;
  }

  Future<String> get fullPath async {
    const name = 'user.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usercode TEXT NOT NULL,
          userName TEXT NOT NULL,
          userEmail TEXT NOT NULL,
          userEmpCode TEXT NOT NULL,
          companyCode TEXT NOT NULL,
          created_at INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int))
        )
      ''');
      },
      singleInstance: true,
    );
    return db;
  }
}
