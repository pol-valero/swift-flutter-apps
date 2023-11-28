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
        // use the same font as the iOS calculator
        fontFamily: 'SF Pro Display',
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
                // space between the text and the border
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                alignment: Alignment.bottomRight,
                child: Text(
                  labelValue,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                buttonOperation('AC'),
                buttonOperation('⁺∕₋'),
                buttonOperation('%'),
                buttonOperation('÷'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                buttonNumber('7'),
                buttonNumber('8'),
                buttonNumber('9'),
                buttonOperation('×'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                buttonNumber('4'),
                buttonNumber('5'),
                buttonNumber('6'),
                buttonOperation('−'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                buttonNumber('1'),
                buttonNumber('2'),
                buttonNumber('3'),
                buttonOperation('+'),
              ],
            ),
            const SizedBox(height: 12),
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
          fontSize: 35,
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
  if (value == 'AC' || value == '⁺∕₋' || value == '%') {
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
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buttonZero(String value) {
  // Double its size and put the text to the left and respect the margin
  return Expanded(
    flex: 2,
    child: TextButton(
      onPressed: () {
        buttonNumberPressed(value);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[850],
        padding: const EdgeInsets.fromLTRB(34, 15, 15, 15),
        shape: const StadiumBorder(),
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

void buttonOperationPressed(String value) {
  print(value);
}