import 'package:flutter/material.dart';
import 'package:notepad/components/editMark.dart';
export 'package:notepad/draw.dart';

class DrawList extends StatefulWidget {
  DrawList({Key key}) : super(key: key);

  @override
  _DrawListState createState() => new _DrawListState();
}

class _DrawListState extends State<DrawList> {
  @override
  Widget build(BuildContext context) {
    final tiles = <Widget>[
      new ListTile(
          title: new Chip(
            avatar: new CircleAvatar(backgroundColor: Colors.yellow.shade50, child: new Icon(Icons.event_note)),
            label: new Text('项目'),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
      ),
      new ListTile(
          title: new Text('备忘录'),
          leading: new Icon(Icons.rate_review),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
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
                child: new Icon(Icons.bookmark)
            ),
            label: new Text('标签'),
          ),
          onTap: _editMark,
      ),
      new ListTile(
        title: new Text('生活'),
        leading: new Icon(Icons.bookmark_border),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      ),
      new ListTile(
          title: new Text('工作'),
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0)
      ),
      new ListTile(
          title: new Text('个人'),
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0)
      ),
      new ListTile(
          title: new Text('旅游'),
          leading: new Icon(Icons.bookmark_border),
          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0)
      ),
    ];

    final divided = ListTile.divideTiles(context: context, tiles: tiles)
        .toList();

    return new ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: divided,
    );
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
}
