import 'package:flutter/material.dart';
export 'package:notepad/components/CreateNote.dart';

class CreateNote extends StatefulWidget {
  CreateNote({Key key}) : super(key: key);
  @override
  _CreateNoteState createState() => new _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('编辑备忘录'),
        automaticallyImplyLeading: true,
        actions: [
          new IconButton(
            icon: new Icon(Icons.check)
          ),
        ]
      ),
      body: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new TextField(
          autofocus: true
        )
      )
    );
  }

}