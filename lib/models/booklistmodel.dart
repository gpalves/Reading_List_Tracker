import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:books_tracker/db.dart';

class BookListModel extends ChangeNotifier {
  final List<Book> _items = [];
  Future<Database> database = DB.db.database;

  List<Book> get items => _items;

  BookListModel() {
    getAllBooks();
  }

  void getAllBooks() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('books');

    maps.forEach((Map<String, dynamic> m) {
      _items.add(Book.favorite(m['name'], m['author'], m['isFavorite'] == 1));
    });

    notifyListeners();
  }

  void add(Book book) async {
    _items.add(book);

    final Database db = await database;

    db.insert('books', book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    notifyListeners();
  }

  void remove(Book book) async {
    _items.remove(book);

    final Database db = await database;

    db.delete('books', where: 'name = ?', whereArgs: [book.name]);

    notifyListeners();
  }

  void favorite(Book book) async {
    final index = _items.indexOf(book);
    _items[index].isFavorite = !_items[index].isFavorite;

    final Database db = await database;

    db.update('books', book.toMap(), where: 'name = ?', whereArgs: [book.name]);

    notifyListeners();
  }
}

class Book {
  String name;
  String author;
  bool isFavorite = false;

  Book(this.name, this.author);
  Book.favorite(this.name, this.author, this.isFavorite);

  Map<String, dynamic> toMap() {
    return {'name': name, 'author': author, 'isFavorite': (isFavorite ? 1 : 0)};
  }
}
