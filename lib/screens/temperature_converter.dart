import 'package:flutter/material.dart';

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double _inputValue = 0.0;
  String _result = '';

  void _convert() {
    double convertedValue = 0.0;

    if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      convertedValue = (_inputValue * 9 / 5) + 32;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      convertedValue = (_inputValue - 32) * 5 / 9;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
      convertedValue = _inputValue + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
      convertedValue = _inputValue - 273.15;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
      convertedValue = (_inputValue - 32) * 5 / 9 + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
      convertedValue = (_inputValue - 273.15) * 9 / 5 + 32;
    } else {
      convertedValue = _inputValue; // Same unit
    }

    setState(() {
      _result = convertedValue.toStringAsFixed(2);
    });
  }

  void _swapUnits() {
    setState(() {
      String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _result = ''; // Reset result after swap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _inputValue = double.tryParse(value) ?? 0.0;
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  items: ['Celsius', 'Fahrenheit', 'Kelvin']
                      .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: _swapUnits,
                ),
                DropdownButton<String>(
                  value: _toUnit,
                  items: ['Celsius', 'Fahrenheit', 'Kelvin']
                      .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

