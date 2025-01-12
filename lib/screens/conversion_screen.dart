import 'package:flutter/material.dart';
import 'temperature_converter.dart';
import 'weight_converter.dart';
import 'currency_converter.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({Key? key}) : super(key: key);

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final List<String> _conversionTypes = ['Temperature', 'Weight', 'Currency'];
  String _selectedType = 'Temperature';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unit Converter"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _selectedType,
              isExpanded: true,
              items: _conversionTypes.map((String type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
          ),
          Expanded(child: _buildConversionWidget()),
        ],
      ),
    );
  }

  Widget _buildConversionWidget() {
    switch (_selectedType) {
      case 'Temperature':
        return const TemperatureConverter();
      case 'Weight':
        return const WeightConverter();
      case 'Currency':
        return const CurrencyConverter();
      default:
        return const SizedBox();
    }
  }
}
