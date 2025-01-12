import 'package:flutter/material.dart';

class WeightConverter extends StatefulWidget {
  const WeightConverter({Key? key}) : super(key: key);

  @override
  State<WeightConverter> createState() => _WeightConverterState();
}

class _WeightConverterState extends State<WeightConverter> {
  String _fromUnit = 'mg';
  String _toUnit = 'g';
  double _inputValue = 0.0;
  String _result = '';

  final Map<String, double> _conversionRates = {
    'mg-g': 0.001,
    'g-mg': 1000.0,
    'g-kg': 0.001,
    'kg-g': 1000.0,
    'kg-ton': 0.001,
    'ton-kg': 1000.0,
    'mg-kg': 0.000001,
    'kg-mg': 1000000.0,
    'mg-ton': 0.000000001,
    'ton-mg': 1000000000.0,
    'g-ton': 0.000001,
    'ton-g': 1000000.0,
  };

  void _convert() {
    String key = '$_fromUnit-$_toUnit';
    if (_conversionRates.containsKey(key)) {
      double rate = _conversionRates[key]!;
      double convertedValue = _inputValue * rate;
      setState(() {
        _result = convertedValue.toStringAsFixed(6); // 6 desimal untuk akurasi
      });
    } else if (_fromUnit == _toUnit) {
      setState(() {
        _result = _inputValue.toStringAsFixed(6); // Sama unitnya, tidak berubah
      });
    } else {
      setState(() {
        _result = 'Conversion not supported.';
      });
    }
  }

  void _swapUnits() {
    setState(() {
      String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _result = ''; // Reset hasil setelah swap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Weight',
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
                  items: ['mg', 'g', 'kg', 'ton']
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
                  items: ['mg', 'g', 'kg', 'ton']
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
