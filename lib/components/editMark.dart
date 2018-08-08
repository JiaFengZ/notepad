import 'package:flutter/material.dart';

class EditMark extends StatefulWidget {
  EditMark({Key key}) : super(key: key);

  @override
  _EditMarkState createState() => new _EditMarkState();
}

class _EditMarkState extends State<EditMark> {
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

  List<Map> _selectedItemList = [];

  bool _removeAble = false;


  @override
  Widget build(BuildContext context) {
    List<Widget> _items = _buildList();
    return new Scaffold(
      appBar: new AppBar(
        leading: _removeAble ?
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: _cancelRemove
          ) :
          new BackButton(),
        title: new Text(_removeAble ? '选择书签' : '编辑书签'),
        automaticallyImplyLeading: true,
      ),
      body: new ListView(
        padding: const EdgeInsets.all(10.0),
        children: _items,
      ),
      persistentFooterButtons: <Widget>[
        new IconButton(icon: new Icon(Icons.add), onPressed: _add),
        new IconButton(icon: new Icon(Icons.delete), onPressed: _enabledRemove)
      ],
    );
  }

  List<Widget> _buildList() {
    return _marks.map(_buildListItem).toList();
  }

  Widget _buildListItem(Map item) {
    final alreadySelected = _selectedItemList.contains(item);
    return new ListTile(
      leading: new Icon(Icons.bookmark),
      title: new TextField(
        maxLines: 1,
        autofocus: true,
        decoration: null,
        controller: new TextEditingController(text: item['name']),
      ),
      trailing: item['isNew'] ? new ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.check), onPressed: null),
          new IconButton(icon: new Icon(Icons.close), onPressed: null)
        ],
      ) : _removeAble ? new ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new IconButton(
              icon: new Icon(
                  alreadySelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: alreadySelected ? Colors.red : null),
              onPressed: () {
                setState(() {
                  if (alreadySelected) {
                    _selectedItemList.remove(item);
                  } else {
                    _selectedItemList.add(item);
                  }
                });
              }
          )
        ],
      ) : null,
    );
  }

  void _add() {
    setState(() {
      final int len = _marks.length;
      _marks.insert(
          0,
          {
            'name': '',
            'id': len.toString(),
            'isNew': true,
            'toRemoveed': false
          }
      );
    });
  }

  void _enabledRemove() {
    setState(() {
      _removeAble = true;
    });
  }

  void _cancelRemove() {
    setState(() {
      _removeAble = false;
    });
  }
}