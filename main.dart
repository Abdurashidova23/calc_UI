import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';

  void onButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        // Hisoblashni amalga oshirish
        try {
          displayText = (double.parse(displayText.split('+')[0]) +
                  double.parse(displayText.split('+')[1]))
              .toString();
        } catch (e) {
          displayText = "Error";
        }
      } else if (displayText == '0') {
        displayText = value;
      } else {
        displayText += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Displey qismi
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              child: Text(
                displayText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Tugmalar qismi
          Expanded(
            flex: 8,
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                for (String label in [
                  '7',
                  '8',
                  '9',
                  '÷',
                  '4',
                  '5',
                  '6',
                  '×',
                  '1',
                  '2',
                  '3',
                  '-',
                  '0',
                  '.',
                  '=',
                  '+'
                ])
                  GestureDetector(
                    onTap: () => onButtonPressed(label),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isOperator(label) ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[400]!),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 24,
                          color:
                              _isOperator(label) ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Operatorlarni aniqlash
  bool _isOperator(String label) {
    return ['÷', '×', '-', '+'].contains(label);
  }
}
