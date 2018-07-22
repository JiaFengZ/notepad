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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget> [new IconButton(
          icon: new Icon(Icons.view_module),
          tooltip: 'Click it',
          onPressed: _decreaseCounter,
        )],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
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

  void _addNote() {
    
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
