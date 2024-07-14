import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConversionApp());
}


class TemperatureConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConversionScreen(),
    );
  }
}

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String _selectedConversion = 'F to C';
  TextEditingController _controller = TextEditingController();
  String _convertedValue = '0.0'; 
  List<String> _history = [];
  bool _showConvertedValue = false;

  void _convertTemperature() {
    double inputValue = double.tryParse(_controller.text) ?? 0;
    double convertedValue;

    if (_selectedConversion == 'F to C') {
      convertedValue = (inputValue - 32) * 5 / 9;
    } else {
      convertedValue = inputValue * 9 / 5 + 32;
    }

    setState(() {
      _convertedValue = convertedValue.toStringAsFixed(1);
      _showConvertedValue = true;
      _history.insert(0, '$_selectedConversion: $inputValue => $_convertedValue');
    });
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var mainAxisSize = isPortrait ? MainAxisSize.min : MainAxisSize.max;

    return Scaffold(
      appBar: AppBar(
        title: Text('Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isPortrait
            ? _buildPortraitLayout(mainAxisSize)
            : _buildLandscapeLayout(mainAxisSize),
      ),
    );
  }

  Widget _buildPortraitLayout(MainAxisSize mainAxisSize) {
    return Column(
      mainAxisSize: mainAxisSize,
      children: [
        _buildConversionSelectors(),
        _buildInputAndConvertedValueRow(),
        _buildConvertButton(),
        _buildHistoryList(),
      ],
    );
  }

  Widget _buildLandscapeLayout(MainAxisSize mainAxisSize) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: mainAxisSize,
            children: [
              _buildConversionSelectors(),
              _buildInputAndConvertedValueRow(),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: mainAxisSize,
            children: [              
              _buildConvertButton(),
              Expanded(child: _buildHistoryList()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConversionSelectors() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
            title: Text('Fahrenheit to Celsius'),
            value: 'F to C',
            groupValue: _selectedConversion,
            onChanged: (value) {
              setState(() {
                _selectedConversion = value.toString();
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: Text('Celsius to Fahrenheit'),
            value: 'C to F',
            groupValue: _selectedConversion,
            onChanged: (value) {
              setState(() {
                _selectedConversion = value.toString();
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInputAndConvertedValueRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('='),
          ),
          Expanded(
            child: AnimatedOpacity(
              opacity: _showConvertedValue ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                _convertedValue,
                key: Key('convertedValue'), 
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _convertTemperature,
      child: Text('Convert'),
    );
  }

  Widget _buildHistoryList() {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Text(
            'History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _history.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_history[index]),
              );
            },
          ),
        ),
      ],
    ),
  );
}

}
