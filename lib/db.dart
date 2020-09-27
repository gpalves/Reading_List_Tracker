import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB db = DB._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "books.db"),
        onCreate: (db, version) => db.execute(
            "CREATE TABLE books (name TEXT PRIMARY KEY, author TEXT, isFavorite INTEGER)"),
        version: 1);
  }
}
