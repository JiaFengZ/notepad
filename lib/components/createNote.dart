import 'package:flutter/material.dart';
import 'package:notepad/DataReader.dart';
export 'package:notepad/components/CreateNote.dart';

class CreateNote extends StatefulWidget {
  CreateNote({Key key, this.insert}) : super(key: key);
  final Function insert;
  @override
    _CreateNoteState createState() => new _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  static List<Map> _marks = [];

  String _fillText;
  String _markId;
  String _markName = '';
  static DateTime _time = new DateTime.now();
  String _timeStr = _time.year.toString() + '-' + _time.month.toString() + '-' + _time.day.toString() + ' ' + _time.hour.toString() + ':' + _time.minute.toString();

  @override
  void initState() {
    super.initState();

    getMarks().then((List<Map> marks) {
      _marks = marks.map((Map mark) {
        final Map<dynamic, dynamic> markItem = {
          'name': mark['name'],
          'id': mark['id'],
          'isNew': false,
          'toRemoveed': false
        };
        return markItem;
      }).toList();
    });
  }

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
            new Row(
              children: <Widget>[
                new Text(
                  _timeStr,
                  textAlign: TextAlign.left,
                  style: new TextStyle(color: Colors.black38, fontSize: 12.0),
                ),
                new Chip(
                  avatar: new CircleAvatar(
                      backgroundColor: Colors.yellow.shade50,
                      child: new Icon(Icons.bookmark_border)
                  ),
                  label: new Text(_markName),
                )
              ]
            ),
            new TextField(
              autofocus: true,
              maxLines: 5,
              decoration: null,
              onChanged: _getInputText
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget> [
        new IconButton(
            icon: new Icon(Icons.check_circle),
            color: Colors.amber,
            onPressed: () {}
        ),
        new IconButton(
            icon: new Icon(Icons.access_time),
            color: Colors.amber,
            onPressed: () {}
        ),
        new IconButton(
          icon: new Icon(Icons.bookmark_border),
          color: Colors.amber,
          onPressed: () {
            showModalBottomSheet(
              builder: (BuildContext context) {
                return new BottomSheet(
                  onClosing: () {
                    return true;
                  },
                  builder: (BuildContext context) {
                    final actions = _buildMarks(_marks, context);
                    return new ListView(
                      padding: const EdgeInsets.all(20.0),
                      children: actions,
                    );
                  }
                );
              },
              context: context
            );
          },
        )
      ]
    );
  }

  void _save() {
    Map item = {'text': _fillText, 'time': _timeStr, '_markId': _markId};
    appendNote(item);
    widget.insert(-1, item);
    Navigator.of(context).pop();
  }

  void _getInputText(String text) {
    _fillText = text;
  }

  List<Widget> _buildMarks(List<Map> marks, BuildContext context) {
    return marks.map((Map mark) {
      return new ListTile(
          title: new Text(mark['name']),
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          onTap: () {
            setState(() {
              _markId = mark['id'];
              _markName = mark['name'];
            });
            Navigator.of(context).pop();
          }
      );
    }).toList();
  }

}