import 'package:flutter/foundation.dart';

class BookListModel extends ChangeNotifier {
  final List<Book> _items = [];

  List<Book> get items => _items;

  void add(Book book) {
    _items.add(book);

    notifyListeners();
  }

  void remove(Book book) {
    _items.remove(book);

    notifyListeners();
  }

  void favorite(Book book) {
    final index = _items.indexOf(book);
    _items[index].isFavorite = !_items[index].isFavorite;

    notifyListeners();
  }
}

class Book {
  String name;
  String author;
  bool isFavorite = false;

  Book(this.name, this.author);
}
