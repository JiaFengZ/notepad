import 'package:flutter/material.dart';
export 'package:notepad/components/CreateNote.dart';

class CreateNote extends StatefulWidget {
  CreateNote({Key key, this.insert}) : super(key: key);
  final Function insert;
  @override
    _CreateNoteState createState() => new _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  static List<Map> _marks = [{
  'name': '笔记',
  'id': '1',
  'isNew': false,
  'toRemoveed': false
  }, {
  'name': '旅游',
  'id': '2',
  'isNew': false,
  'toRemoveed': false
  }, {
  'name': '生活',
  'id': '3',
  'isNew': false,
  'toRemoveed': false
  }, {
  'name': '工作',
  'id': '4',
  'isNew': false,
  'toRemoveed': false
  }, {
  'name': '学习',
  'id': '5',
  'isNew': false,
  'toRemoveed': false
  }];

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
                    final actions = _buildMarks(_marks);
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
    Map item = {'text': _fillText, 'time': _timeStr};
    widget.insert(-1, item);
    Navigator.of(context).pop();
  }

  void _getInputText(String text) {
    _fillText = text;
  }

  List<Widget> _buildMarks(List<Map> marks) {
    return marks.map((Map mark) {
      return new ListTile(
          title: new Text(mark['name']),
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          onTap: () {

          }
      );
    }).toList();
  }

}