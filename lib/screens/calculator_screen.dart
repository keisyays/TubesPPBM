import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _result = "";

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_expression);
          ContextModel cm = ContextModel();
          _result = exp.evaluate(EvaluationType.REAL, cm).toString();
        } catch (e) {
          _result = "Error";
        }
      } else if (value == "C") {
        _expression = "";
        _result = "";
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String text, {Color? color}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24.0),
          backgroundColor: color ?? Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => _onButtonPressed(text),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 32, color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.white24),
          _buildKeypad(),
        ],
      ),
    );
  }

  Widget _buildKeypad() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/", color: Colors.orange),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("*", color: Colors.orange),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-", color: Colors.orange),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildButton("C", color: Colors.red),
              _buildButton("0"),
              _buildButton("=", color: Colors.green),
              _buildButton("+", color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
