import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String labelValue = '0';
  double actualValue1 = 0;
  double actualValue2 = 0;
  String operation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  labelValue,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                buttonOperation('AC'),
                buttonOperation('+/-'),
                buttonOperation('%'),
                buttonOperation('÷'),
              ],
            ),
            Row(
              children: [
                buttonNumber('7'),
                buttonNumber('8'),
                buttonNumber('9'),
                buttonOperation('X'),
              ],
            ),
            Row(
              children: [
                buttonNumber('4'),
                buttonNumber('5'),
                buttonNumber('6'),
                buttonOperation('-'),
              ],
            ),
            Row(
              children: [
                buttonNumber('1'),
                buttonNumber('2'),
                buttonNumber('3'),
                buttonOperation('+'),
              ],
            ),
            Row(
              children: [
                buttonZero('0'),
                buttonNumber('.'),
                buttonOperation('='),
              ],
            ),
          ],
        ),
      ),
    );
  }


}

Widget buttonNumber(String value) {
  return Expanded(
    child: TextButton(
      onPressed: () {
        buttonNumberPressed(value);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[850],
        padding: const EdgeInsets.all(15),
        shape: const CircleBorder(),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

void buttonNumberPressed(String value) {
  print(value);
}

Widget buttonOperation(String value) {
  // put a hex color variable
  Color btnBackground = Colors.orange;
  Color btnForeground = Colors.white;
  if (value == 'AC' || value == '+/-' || value == '%') {
    btnBackground = Colors.grey[400]!;
    btnForeground = Colors.black;
  }
  return Expanded(
    child: TextButton(
      onPressed: () {
        buttonOperationPressed(value);
      },
      style: TextButton.styleFrom(
        backgroundColor: btnBackground,
        padding: const EdgeInsets.all(15),
        shape: const CircleBorder(),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: btnForeground,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buttonZero(String value) {
  return Expanded(
    child: TextButton(
      onPressed: () {
        buttonOperationPressed(value);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[850],
        padding: const EdgeInsets.fromLTRB(15, 15, 120, 15),
        shape: const StadiumBorder(),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

void buttonOperationPressed(String value) {
  print(value);
}