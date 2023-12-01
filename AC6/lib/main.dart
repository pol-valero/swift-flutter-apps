import 'dart:core';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
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

  double resultValue = 0;
  double actualValue1 = 0;
  double actualValue2 = 0;
  bool hasOperation = false;
  bool hasComma = false;
  int commaCounter = 0;
  int numDigitsEntered = 0;
  bool resultHasDecimals = false;
  String lastOperation= '';

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
                child: AutoSizeText(
                  labelValue,
                  maxLines: 1,
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

  void clearCalculation() {
    resultValue = 0;
    actualValue1 = 0;
    actualValue2 = 0;
    hasOperation = false;
    hasComma = false;
    commaCounter = 0;
    updateResultLabel(0);
    numDigitsEntered = 0;
    resultHasDecimals = false;
  }

  void calculateResult() {
    if (hasOperation) {
      performOperation(lastOperation);
      updateResultLabel(resultValue);
    } else {
      updateResultLabel(resultValue);
    }
    hasComma = false;
    commaCounter = 0;
    hasOperation = false;
  }

  void performOperation (String operator) {
    print("operator perform:$operator");
    switch (operator) {
      case '+':
        resultValue = actualValue1 + actualValue2;
        break;
      case '−':
        resultValue = actualValue1 - actualValue2;
        break;
      case '×':
        resultValue = actualValue1 * actualValue2;
        break;
      case '÷':
        resultValue = actualValue1 / actualValue2;
        break;
      default:
        resultValue = 0;
    }

    // check if the result has decimals
    if (resultValue % 1 == 0) {
      resultHasDecimals = false;
    } else {
      resultHasDecimals = true;
    }

    actualValue1 = resultValue;
    actualValue2 = 0;

  }

  void operatorClicked(String operator) {
    numDigitsEntered = 0;
    resultHasDecimals = false;

    // TAG 1 = + ; 2 = - ; 3 = x ; 4 = /
    if (hasOperation) {
      performOperation(operator);
      updateResultLabel(resultValue);
    } else {
      hasOperation = true;
    }
    hasComma = false;
    commaCounter = 0;
  }

  void plusMinusClicked() {
    if (hasOperation) {
      actualValue2 = actualValue2 * -1;
      updateResultLabel(actualValue2);
    } else {
      actualValue1 = actualValue1 * -1;
      updateResultLabel(actualValue1);
    }

    hasComma = false;
    commaCounter = 0;
  }

  void percentageCalculation() {
    numDigitsEntered = 0;

    if (hasOperation) {
      actualValue2 = actualValue2 / 100;
      updateResultLabel(actualValue2);
    } else {
      actualValue1 = actualValue1 / 100;
      updateResultLabel(actualValue1);
    }

    hasComma = false;
    commaCounter = 0;

  }

  void buttonOperationPressed(String value) {

    //The +, -, x, /, +-, =, % has been pressed

    switch (value) {

      case 'AC':
        clearCalculation();
        break;
      case '⁺∕₋':
        plusMinusClicked();
        break;
      case '%':
        percentageCalculation();
        break;
      case '÷':
        operatorClicked('÷');
        break;
      case '×':
        operatorClicked('×');
        break;
      case '−':
        operatorClicked('−');
        break;
      case '+':
        operatorClicked('+');
        break;
      case '=':
        calculateResult();
        break;
    }
    lastOperation = value;

  }

  void updateResultLabel(double value) {

    //if value has no decimals, then we show it as an integer
    if (value % 1 == 0) {
      labelValue = value.toInt().toString();
    } else {
      labelValue = value.toString();
    }

    //labelValue =  value.toString();

    setState(() {});
  }

  void flotantClicked() {
    if (resultHasDecimals) {
      hasComma = false;
    } else {
      //If no decimals are already in the result, we can add decimals
      hasComma = true;
    }
  }

  void buttonNumberPressed(String value) {
    if (value == '.') {
      flotantClicked();
    } else {
      numDigitsEntered += 1;

      // TAG = Number value
      if (hasOperation) {
        if (hasComma) {
          commaCounter += 1;
          actualValue2 =
              actualValue2 + double.parse(value) / pow(10, commaCounter);
          updateResultLabel(actualValue2);
        } else {
          actualValue2 = actualValue2 * 10 + double.parse(value);
          updateResultLabel(actualValue2);
        }
      } else {
        if (numDigitsEntered <= 9) {
          if (hasComma) {
            commaCounter += 1;
            actualValue1 =
                actualValue1 + double.parse(value) / pow(10, commaCounter);
            updateResultLabel(actualValue1);
          } else {
            actualValue1 = actualValue1 * 10 + double.parse(value);
            updateResultLabel(actualValue1);
          }
        }
      }
    }
  }

}

