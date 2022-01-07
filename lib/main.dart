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
      title: "Stephan's simple dice",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DicePage(title: "Stephan's simple dice"),
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
      if (eyes > 0) {
        _eyes = eyes;
      }
      if (number > 0) {
        _number = number;
      }
      _results.clear();
      _sum = 0;
      for (int c = 0; c < _number; c++) {
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
            Container(
              child: Row(
                children: [
                  NumberPicker(
                      minValue: 1,
                      maxValue: 100,
                      value: _number,
                      textStyle: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                      onChanged: (value) => _updateDice(_eyes, value)),
                  const Text('D',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  NumberPicker(
                    minValue: 1,
                    maxValue: 100,
                    value: _eyes,
                    onChanged: (value) => _updateDice(value, _number),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              color: Colors.grey[300],
            ),
            ElevatedButton(
              onPressed: () => _updateDice(_eyes, _number),
              child: const Text('Roll'),
            ),
            Text(
              'Sum: $_sum',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Results: ${_results.join(', ')}"),
          ],
        ),
      ),
    );
  }
}
