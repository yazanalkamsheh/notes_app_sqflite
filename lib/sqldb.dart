import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initialDb();
    return _db;
  }

  initialDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,'notesapp.db');
    Database myDb = await openDatabase(path , onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

   _onUpgrade(Database db, int oldVersion, int newVersion) async {
     // await db.execute(sql);
  }

  _onCreate(Database db, int version) async {
    // Batch batch = db.e();

    await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,
            title TEXT NOT NULL,
            note TEXT NOT NULL
          )
          ''');
  }

  // use query when read data
  readData(String sql) async {
      Database? myDb = await db;
      List<Map> response = await myDb!.rawQuery(sql);
      return response;
  }

  // use query when insert data
  insertData(String sql) async {
      Database? myDb = await db;
      int response = await myDb!.rawInsert(sql);
      return response;
  }

  // use query when update data
  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  // use query when delete data
  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  // use method build in sqflite when read data
  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;

  }

  // use method build in sqflite when insert data
  insert(String table, Map<String,Object?> values) async {
      Database? myDb = await db;
      int response = await myDb!.insert(table, values);
      return response;
  }

  // use method build in sqflite when update data
  update(String table, Map<String,Object?> values, String? mywhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: mywhere);
    return response;
  }

  // use method build in sqflite when delete data
  delete(String table, String? mywhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table,where: mywhere);
    return response;
  }

  deleteDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath,'notes.db');
    await deleteDatabase(path);
  }

}



