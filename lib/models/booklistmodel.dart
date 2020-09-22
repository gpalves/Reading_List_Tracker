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
}

class Book {
  String name;

  Book(this.name);
}
