import 'package:flutter/material.dart';
import 'package:notepad/components/editMark.dart';
import 'package:notepad/DataReader.dart';
export 'package:notepad/draw.dart';

class DrawList extends StatefulWidget {
  DrawList({Key key, @required this.notes, @required this.filterNotes}) : super(key: key);
  final List<Map> notes;
  final ValueChanged<String> filterNotes;

  @override
  _DrawListState createState() => new _DrawListState();
}

class _DrawListState extends State<DrawList> {

  List<Map> _marks = [];
  int _notesLength = 0;
  int _staredLength = 0;

  @override
  void initState() {
    super.initState();
    updateMarks(1);
  }

  @override
  Widget build(BuildContext context) {
    _notesLength = widget.notes.length;
    _staredLength = 0;
    _marks.forEach((Map mark) {
      mark['noteNum'] = 0;
    });
    widget.notes.forEach((Map note) {
      final bool stared = note['star'] ?? false;
      if (stared) {
        _staredLength++;
      }
      _marks.forEach((Map mark) {
        if (mark['id'] == note['markId']) {
          mark['noteNum']++;
        }
      });
    });

    final tiles = <Widget>[
      new ListTile(
          title: new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.yellow.shade50,
                child: new Icon(Icons.event_note)
            ),
            label: new Text('项目'),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
      ),
      new ListTile(
          title: new Chip(
            label: new Text('备忘录 '),
            avatar: new CircleAvatar(
                backgroundColor: Colors.yellow.shade50,
                child: new Text(_notesLength.toString())
            ),
          ),
          leading: new Icon(Icons.rate_review),
          onTap: () {
            widget.filterNotes('all');
            Navigator.of(context).pop();
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
      ),
      new ListTile(
          title: new Chip(
            label: new Text('收藏 '),
            avatar: new CircleAvatar(
                backgroundColor: Colors.yellow.shade50,
                child: new Text(_staredLength.toString())
            ),
          ),
          onTap: () {
            widget.filterNotes('star');
            Navigator.of(context).pop();
          },
          leading: new Icon(Icons.star_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
      ),
      new ListTile(
          title: new Chip(
            avatar: new CircleAvatar(
                backgroundColor: Colors.yellow.shade50,
                child: new Icon(Icons.edit)
            ),
            label: new Text('编辑标签'),
          ),
          onTap: _editMark,
      ),
    ];

    tiles.addAll(_buildMarks(_marks, context));

    final divided = ListTile.divideTiles(context: context, tiles: tiles)
        .toList();

    return new ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: divided,
    );
  }

  List<Widget> _buildMarks(List<Map> marks, BuildContext context) {
    return marks.map((Map mark) {
      return new ListTile(
          title: new Chip(
            label: new Text(mark['name']),
            avatar: new CircleAvatar(
                backgroundColor: Colors.yellow.shade50,
                child: new Text(mark['noteNum'].toString())
            ),
          ),
          onTap: () {
            widget.filterNotes(mark['name'] + '-' + mark['id']);
            Navigator.of(context).pop();
          },
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
      );
    }).toList();
  }

  void updateMarks(int flag) {
    getMarks().then((List<Map> marks) {
      setState(() {
        _marks = marks.map((Map mark) {
          final Map<dynamic, dynamic> markItem = {
            'name': mark['name'],
            'id': mark['id'],
            'noteNum': 0
          };
          return markItem;
        }).toList();
      });
    });
  }

  void _editMark() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new EditMark(updateMarks: updateMarks);
        },
      ),
    );
  }

}
