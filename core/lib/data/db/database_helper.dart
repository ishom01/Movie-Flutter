import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../../common/home_enum.dart';
import '../models/movie_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 2, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        dbId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        id INTEGER,
        type INTEGER,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(WatchlistTable watchListData) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, watchListData.toJson());
  }

  Future<int> removeWatchlist(WatchlistTable watchListData) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [watchListData.id],
    );
  }

  Future<Map<String, dynamic>?> getWatchlistById(int id, DataType type) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? AND type = ?',
      whereArgs: [id, type.index],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
