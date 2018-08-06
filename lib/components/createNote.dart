import 'package:flutter/material.dart';
export 'package:notepad/components/CreateNote.dart';

class CreateNote extends StatefulWidget {
  CreateNote({Key key, this.insert}) : super(key: key);
  final Function insert;
  @override
    _CreateNoteState createState() => new _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  String _fillText;
  static DateTime _time = new DateTime.now();
  String _timeStr = _time.year.toString() + '-' + _time.month.toString() + '-' + _time.day.toString() + ' ' + _time.hour.toString() + ':' + _time.minute.toString();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('编辑备忘录'),
        automaticallyImplyLeading: true,
        actions: [
          new IconButton(
            icon: new Icon(Icons.check),
            onPressed: _save,
          ),
        ]
      ),
      body: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text(
              _timeStr,
              textAlign: TextAlign.left,
              style: new TextStyle(color: Colors.black38, fontSize: 12.0),
            ),
            new TextField(
              autofocus: true,
              maxLines: 5,
              decoration: null,
              onChanged: _getInputText
            ),
          ],
        ),
      )
    );
  }

  void _save() {
    Map item = {'text': _fillText, 'time': _timeStr};
    widget.insert(-1, item);
    Navigator.of(context).pop();
  }

  void _getInputText(String text) {
    _fillText = text;
  }

}