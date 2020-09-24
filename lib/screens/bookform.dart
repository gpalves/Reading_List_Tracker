import 'package:flutter/material.dart';
import 'package:books_tracker/models/booklistmodel.dart';

class BookForm extends StatefulWidget {
  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final authorNameController = TextEditingController();

  @override
  void dispose() {
    bookNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Form"),
      ),
      body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Book Name:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer()
                ],
              ),
            ),
            TextFormField(
              controller: bookNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a book name';
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    "Author:",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer()
                ],
              ),
            ),
            TextFormField(
              controller: authorNameController,
              validator: (value) {
                return null;
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //Do Something
                  if (authorNameController.text == null) {
                    Navigator.pop(context, Book(bookNameController.text, ""));
                  }
                  Navigator.pop(context,
                      Book(bookNameController.text, authorNameController.text));
                }
              },
              child: Text("Submit"),
            )
          ])),
    );
  }
}
