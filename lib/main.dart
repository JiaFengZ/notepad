import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '备忘录',
      theme: new ThemeData(
        primaryColor: Colors.white
      ),
      home: new MyHomePage(title: '备忘录'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> _listKey = new GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem; // The next item inserted when the user presses the '+' button.

  @override
  void initState() {
    super.initState();
    _list = new ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
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

  Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
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
            icon: const Icon(Icons.remove_circle),
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
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
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
              color: Colors.primaries[item % Colors.primaries.length],
              child: new Center(
                child: new Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




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
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
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
            avatar: new CircleAvatar(backgroundColor: Colors.yellow.shade50, child: new Icon(Icons.bookmark)),
            label: new Text('标签'),
          ),
          subtitle: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5.0),
            children: <Widget>[
              new ListTile(
                  title: new Text('生活'),
                  leading: new Icon(Icons.bookmark_border),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0)
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
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14.0)
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
}
