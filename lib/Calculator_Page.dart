import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Removed "final" keyword from controllers
  TextEditingController _myNum1 = TextEditingController();
  TextEditingController _myNum2 = TextEditingController();
  TextEditingController _totalNum = TextEditingController();
  double result = 0;

  // Logic to handle all arithmetic operations
  void _calculate(String operation) {
    setState(() {
      double? input1 = double.tryParse(_myNum1.text);
      double? input2 = double.tryParse(_myNum2.text);

      if (input1 != null && input2 != null) {
        if (operation == '+') {
          result = input1 + input2;
        } else if (operation == '-') {
          result = input1 - input2;
        } else if (operation == '*') {
          result = input1 * input2;
        } else if (operation == '/') {
          // Check for division by zero
          result = input2 != 0 ? input1 / input2 : 0;
        }

        // Update the TOTAL text field
        _totalNum.text = result.toStringAsFixed(2);
      } else {
        debugPrint("Invalid input: Please enter numbers in both fields");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black,
        title: const Text(
          "Calculator Page",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 430,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
            child: Column(
              children: [
                _buildHeaderIcon(),
                const SizedBox(height: 20),

                // Input 1
                _buildTextField(_myNum1, "INPUT NUMBER 1"),
                const SizedBox(height: 10),

                // Input 2
                _buildTextField(_myNum2, "INPUT NUMBER 2"),
                const SizedBox(height: 10),

                // Result Display Field
                _buildTextField(_totalNum, "TOTAL", isReadOnly: true),

                const SizedBox(height: 20),
                Text(
                  'Display Result: $result',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 25),

                // Operator Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _calcButton("+", () => _calculate('+')),
                    _calcButton("-", () => _calculate('-')),
                    _calcButton("×", () => _calculate('*')),
                    _calcButton("÷", () => _calculate('/')),
                  ],
                ),

                const SizedBox(height: 20),

                // Clear Button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    onPressed: () {
                      _myNum1.clear();
                      _myNum2.clear();
                      _totalNum.clear();
                      setState(() => result = 0);
                    },
                    child: const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- UI Helper Methods ---

  Widget _buildHeaderIcon() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.calculate, size: 40, color: Colors.blue),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isReadOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: isReadOnly,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _calcButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 119, 184, 196),
        foregroundColor: Colors.black,
        minimumSize: const Size(60, 60),
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 22)),
    );
  }
}
