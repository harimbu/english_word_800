import 'dart:async';
import 'dart:io' as io;
import 'package:english_word_800/model/word_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "english800.db");
    bool dbExists = await io.File(path).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "english800.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  Future<List<WordModel>> getAllItems() async {
    var dbClient = await db;
    List<Map> rows = await dbClient!.rawQuery('SELECT * FROM word');
    List<WordModel> wordList = [];
    for (int i = 0; i < rows.length; i++) {
      wordList.add(
        WordModel(
          id: rows[i]['id'],
          title: rows[i]['title'],
          kor: rows[i]['kor'],
          eng: rows[i]['eng'],
          done: rows[i]['done'],
          showing: rows[i]['showing'],
          adding: rows[i]['adding'],
        ),
      );
    }
    return wordList;
  }

  // Update an item by id
  Future<int> updateShow(int id, int showing) async {
    var dbClient = await db;

    final data = {
      'showing': showing,
    };

    final result =
        await dbClient!.update('word', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Update an item by id
  Future<int> updateAdd(int id, int adding) async {
    var dbClient = await db;

    final data = {
      'adding': adding,
    };

    final result =
        await dbClient!.update('word', data, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
