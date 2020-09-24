import 'package:books_tracker/models/booklistmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:books_tracker/screens/bookform.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => new BookListModel(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  _getNewBook(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => BookForm()));

    if (result != null) {
      context.read<BookListModel>().add(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Book Tracker',
        home: Scaffold(
            appBar: AppBar(title: Text("Welcome to Books")),
            body: Center(child: BookList()),
            floatingActionButton: Builder(
                builder: (context) => FloatingActionButton(
                      onPressed: () {
                        _getNewBook(context);
                      },
                      tooltip: 'New Book',
                      child: const Icon(Icons.add),
                    ))));
  }
}

class BookList extends StatelessWidget {
  Widget _buildRow(Book book, BuildContext context, _books, index) {
    return Dismissible(
      key: Key(book.name),
      background: Container(
          color: Colors.red,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 48,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          )),
      onDismissed: (direction) {
        Provider.of<BookListModel>(context, listen: false).remove(book);
      },
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(book.name, style: TextStyle(fontSize: 18.0)),
        subtitle: Text(book.author),
        trailing:
            Icon(book.isFavorite ? Icons.favorite : Icons.favorite_border),
        onLongPress: () {
          Provider.of<BookListModel>(context, listen: false).favorite(book);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _books = context.watch<BookListModel>().items;

    return ListView.builder(
      itemCount: _books.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;

        if (index < _books.length) {
          return _buildRow(_books[index], context, _books, index);
        }
      },
    );
  }
}
