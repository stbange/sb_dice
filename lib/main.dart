import 'package:flutter/material.dart';
import 'dart:math';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const DicePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  final Random _random = Random();
  int _eyes = 6;
  int _number = 3;
  final List<int> _results = [];
  int _sum = 0;

  void _updateDice(int eyes, int number) {
    setState(() {
      if(eyes > 0) {
        _eyes = eyes;
      }
      if(number > 0) {
        _number = number;
      }
      _results.clear();
      _sum = 0;
      for(int c=0; c<_number; c++) {
        int current = _random.nextInt(_eyes) + 1;
        _results.add(current);
        _sum += current;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: [
              const Text('Eyes: '),
              NumberPicker(minValue: 1, maxValue: 100, value: _eyes, onChanged: (value) => _updateDice(value, _number))
            ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(children: [
              const Text( 'Number: '),
              NumberPicker(minValue: 1, maxValue: 100, value: _number, onChanged: (value) => _updateDice(_eyes, value))
            ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            ElevatedButton(
              onPressed: () => _updateDice(_eyes, _number),
              child: const Text('Roll'),
            ),
            Row(children: [
              const Text('Sum: '),
              Text('$_sum'),
            ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Row(children: [
              const Text('Results: '),
              Text(_results.join(', '))
            ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
