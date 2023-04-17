import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentCounterIndex = 0;
  List<int> _counters = [0, 0, 0];

  void _incrementCounter() {
    setState(() {
      _counters[_currentCounterIndex]++;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Counter $_currentCounterIndex incremented')),
      );
    });
  }

  void _decrementCounter() {
    setState(() {
      _counters[_currentCounterIndex]--;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Counter $_currentCounterIndex decremented')),
      );
    });
  }

  void _resetCounter() {
    setState(() {
      _counters[_currentCounterIndex] = 0;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Counter $_currentCounterIndex reset')),
      );
    });
  }

  void _switchCounter(int index) {
    setState(() {
      _currentCounterIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter $_currentCounterIndex',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '${_counters[_currentCounterIndex]}',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: Text('-'),
                ),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: Text('+'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: Text('Reset'),
                ),
                ElevatedButton(
                  onPressed: () => _switchCounter(1),
                  child: Text('User Counter 1'),
                ),
                ElevatedButton(
                  onPressed: () => _switchCounter(2),
                  child: Text('User Counter 2'),
                ),




              ],
            ),
          ],
        ),
      ),
    );
  }
}
