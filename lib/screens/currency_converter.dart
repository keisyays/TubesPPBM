import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String _fromCurrency = 'IDR';
  String _toCurrency = 'USD';
  double _inputValue = 0.0;
  String _result = '';

  final Map<String, double> _exchangeRates = {
    'IDR-USD': 0.000065,
    'USD-IDR': 15400.0,
    'USD-WON': 1300.0,
    'WON-USD': 0.00077,
    'USD-YEN': 133.0,
    'YEN-USD': 0.0075,
  };

  void _convert() {
    String key = '$_fromCurrency-$_toCurrency';
    if (_exchangeRates.containsKey(key)) {
      double rate = _exchangeRates[key]!;
      double convertedValue = _inputValue * rate;
      setState(() {
        _result = convertedValue.toStringAsFixed(2);
      });
    } else {
      setState(() {
        _result = 'Conversion not supported.';
      });
    }
  }

  void _swapCurrencies() {
    setState(() {
      String temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _result = ''; // Reset result after swap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
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
                  value: _fromCurrency,
                  items: ['IDR', 'USD', 'WON', 'YEN']
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz),
                  onPressed: _swapCurrencies,
                ),
                DropdownButton<String>(
                  value: _toCurrency,
                  items: ['IDR', 'USD', 'WON', 'YEN']
                      .map((currency) => DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
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
