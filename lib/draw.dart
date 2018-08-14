import 'package:flutter/material.dart';
import 'package:notepad/components/editMark.dart';
import 'package:notepad/FileReader.dart';
export 'package:notepad/draw.dart';

class DrawList extends StatefulWidget {
  DrawList({Key key}) : super(key: key);

  @override
  _DrawListState createState() => new _DrawListState();
}

class _DrawListState extends State<DrawList> {

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

  @override
  Widget build(BuildContext context) {
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
          title: new Text('备忘录'),
          leading: new Icon(Icons.rate_review),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          onTap: _testFileStore,
      ),
      new ListTile(
          title: new Text('待办'),
          leading: new Icon(Icons.check_circle),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
      ),
      new ListTile(
          title: new Text('提醒'),
          leading: new Icon(Icons.access_time),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
      ),
      new ListTile(
          title: new Text('收藏'),
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

    tiles.addAll(_buildMarks(_marks));

    final divided = ListTile.divideTiles(context: context, tiles: tiles)
        .toList();

    return new ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: divided,
    );
  }

  List<Widget> _buildMarks(List<Map> marks) {
    return marks.map((Map mark) {
      return new ListTile(
          title: new Text(mark['name']),
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
      );
    }).toList();
  }

  _editMark() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new EditMark();
        },
      ),
    );
  }

  void _testFileStore() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new ReadAndWriteDemo();
        },
      ),
    );
  }
}
