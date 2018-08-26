import 'package:flutter/material.dart';
import 'package:notepad/draw.dart';
import 'package:notepad/components/CreateNote.dart';
import 'package:notepad/DataReader.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<AnimatedListState>();
  ListModel<Map> _list;
  Map _selectedItem;

  @override
  void initState() {
    super.initState();
    _list = new ListModel<Map>(
      listKey: _listKey,
      initialItems: [],
      removedItemBuilder: _buildRemovedItem,
    );

    getNotes().then((List<Map> notes) {
      notes.forEach((Map note) {
        _list.insert(-1, note);
      });
    });
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(Map item, BuildContext context, Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: item,
      selected: false
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new CreateNote(insert: _list.insert);
        },
      ),
    );
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      final index = _list.indexOf(_selectedItem);
      removeNote(index).then((Object item) {
        _list.removeAt(index);
      });
      setState(() {
        _selectedItem = null;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget> [
          new IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _remove,
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new AnimatedList(
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _insert,
        backgroundColor: Colors.white,
        foregroundColor: Colors.amber,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      drawer: new Drawer(
        child: new DrawList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  }) : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = new List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    index = index == -1 ? _items.length : index;
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index, (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;
  E operator [](int index) => _items[index];
  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.animation,
    this.onTap,
    @required this.item,
    this.selected: false
  }) : assert(animation != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Map item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    final String markerName = item['markName'] ?? '';
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: new SizedBox(
            height: 128.0,
            child: new Card(
              color: selected ? Colors.cyan : Colors.white,
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            item['text'] ?? '',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: new TextStyle(color: selected ? Colors.white : Colors.black87, fontSize: 16.0),
                          ),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            item['time'] ?? '',
                            textAlign: TextAlign.left,
                            style: new TextStyle(fontSize: 12.0, color: selected ? Colors.white : Colors.black38),
                          ),
                          new Chip(
                            avatar: new CircleAvatar(
                                backgroundColor: markerName.isNotEmpty ? Colors.yellow.shade50 : Colors.transparent,
                                child: markerName.isNotEmpty ? new Icon(Icons.bookmark_border) : null
                            ),
                            backgroundColor: markerName.isNotEmpty ? Colors.yellow.shade50 : Colors.transparent,
                            label: new Text(markerName),
                          )
                        ],
                      )
                    ]
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}
