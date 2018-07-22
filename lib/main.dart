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
        leading: new Icon(Icons.change_history),
        title: new Text('关闭'),
        onTap: () {
          // change app state...
          Navigator.pop(context); // close the drawer
        },
      ),
      new ListTile(
          title: new Text('备忘录'),
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
