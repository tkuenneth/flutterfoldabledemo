import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _title = "FlutterFoldableDemo";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _colors = [
    Colors.red,
    Colors.deepOrange,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.purple,
    Colors.deepPurple
  ];

  var _selectedTab = 0;
  var _selectedColor = -1;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < _colors.length; i++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () => setState(() {
                    _selectedColor = i;
                  }),
              child: Container(color: _colors[i], height: 400)),
        )
    ];

    return AdaptiveScaffold(
      useDrawer: false,
      selectedIndex: _selectedTab,
      onSelectedIndexChange: (int index) {
        setState(() {
          _selectedTab = index;
          _selectedColor = -1;
        });
      },
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(Icons.inbox),
          label: '#1',
        ),
        NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: '#2',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: '#3',
        ),
      ],
      body: (_) => GridView.count(crossAxisCount: 2, children: children),
      smallBody: (_) => ListView.builder(
        itemCount: children.length,
        itemBuilder: (_, int idx) => children[idx],
      ),
      // Define a default secondaryBody.
      secondaryBody: (_) => _getSecondaryBody(),
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }

  Widget _getSecondaryBody() {
    return Container(
        color:
            _selectedColor == -1 ? Colors.transparent : _colors[_selectedColor],
        child: Center(
            child: Text(
                _selectedColor == -1
                    ? "no color selected"
                    : "${_colors[_selectedColor].red}, ${_colors[_selectedColor].green}, ${_colors[_selectedColor].blue}",
                style: TextStyle(
                    fontSize: 30,
                    color:
                        _selectedColor == -1 ? Colors.black : Colors.white))));
  }
}
