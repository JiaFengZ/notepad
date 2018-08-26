import 'package:flutter/material.dart';
import 'package:notepad/DataReader.dart';

class EditMark extends StatefulWidget {
  EditMark({Key key, this.updateMarks}) : super(key: key);
  final ValueChanged<int> updateMarks;

  @override
  _EditMarkState createState() => new _EditMarkState();
}

class _EditMarkState extends State<EditMark> {
  List<Map> _marks = [];

  List<Map> _selectedItemList = [];
  bool _removeAble = false;
  bool _buttonAble = true;

  @override
  void initState() {
    super.initState();

    getMarks().then((List<Map> marks) {
      setState(() {
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
    });
  }


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
        actions: _removeAble ? <Widget> [
           new IconButton(
              icon: new Icon(Icons.delete_forever),
              onPressed: _saveRemove
          )
        ] : null
      ),
      body: new ListView(
        padding: const EdgeInsets.all(10.0),
        children: _items,
      ),
      persistentFooterButtons: <Widget>[
        new IconButton(
            icon: new Icon(Icons.add),
            color: Colors.amber,
            disabledColor: Colors.black12,
            onPressed: _buttonAble ? _add : null
        ),
        new IconButton(
            icon: new Icon(Icons.delete),
            color: Colors.amber,
            disabledColor: Colors.black12,
            onPressed: _buttonAble ? _enabledRemove : null
        )
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
        autofocus: item['isNew'] ? true : false,
        decoration: null,
        controller: new TextEditingController(text: item['name']),
        onChanged: (String value) {
          item['name'] = value;
        }
      ),
      trailing: item['isNew'] ? new ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.check),
              onPressed: _saveAdd
          ),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: _cancelAdd
          )
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
      _buttonAble = false;
      _marks.insert(
          0,
          {
            'name': '',
            'id': new DateTime.now().millisecond.toString(),
            'isNew': true,
            'toRemoveed': false
          }
      );
    });
  }

  void _enabledRemove() {
    setState(() {
      _removeAble = true;
      _buttonAble = false;
    });
  }

  void _cancelRemove() {
    setState(() {
      _removeAble = false;
      _buttonAble = true;
      _selectedItemList.length = 0;
    });
  }

  void _saveRemove() {
    setState(() {
      _selectedItemList.forEach((Map item) {
        _marks.remove(item);
      });
      final List<String> ids = _selectedItemList.map((Map item) {
        String id = item['id'];
        return id;
      }).toList();
      removeMarks(ids).then((file) {
        widget.updateMarks(-1);
      });
      _selectedItemList.length = 0;
      _buttonAble = true;
      _removeAble = false;
    });
  }

  void _cancelAdd() {
    setState(() {
      _buttonAble = true;
      _marks.removeAt(0);
    });
  }

  void _saveAdd() {
    setState(() {
      final String _name = _marks[0]['name'];
      if (_name.trim().isNotEmpty) {
        _marks[0]['isNew'] = false;
        _marks[0]['name'] = _name.trim();
        Map mark = {
          'id': _marks[0]['id'],
          'name': _marks[0]['name']
        };
        appendMark(mark).then((file) {
          widget.updateMarks(1);
        });
      } else {
        _marks.removeAt(0);
      }
      _buttonAble = true;
    });
  }

}