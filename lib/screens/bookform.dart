import 'package:flutter/material.dart';
import 'package:books_tracker/models/booklistmodel.dart';

class BookForm extends StatefulWidget {
  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final formController = TextEditingController();

  @override
  void dispose() {
    formController.dispose();
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
            TextFormField(
              controller: formController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a book name';
                }
                return null;
              },
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  //Do Something

                  Navigator.pop(context, Book(formController.text));
                }
              },
              child: Text("Submit"),
            )
          ])),
    );
  }
}
