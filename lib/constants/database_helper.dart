import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "TestingScreen.db";
  static const _databaseVersion = 1;

  static const table = "my_table";

  static const columnId = '_id';
  static const columnTitle = 'title';
  static const columnDescription = 'desc';
  static const columnImage = 'image';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory databaseDirectory = await getApplicationDocumentsDirectory();

    String path = join(databaseDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table ( 
    $columnId INTEGER PRIMARY KEY,
    $columnTitle TEXT NOT NULL,
    $columnDescription TEXT NOT NULL,
    $columnImage TEXT NOT NULL
    )
    ''');
  }

  //Helper Methods CRUD

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  void querySpecificData() async{
    Database db = await instance.database;
    final data = await db.rawQuery('SELECT $columnImage FROM $table WHERE $columnId ?', ['0']);
    debugPrint('Returned Data $data');
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> rowCount() async {
    Database db = await instance.database;

    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  void deleteAllData() async {
    Database db = await instance.database;
    //db.execute("DELETE FROM $table");
    db.delete(table);
    debugPrint('table deleted');
  }


}
