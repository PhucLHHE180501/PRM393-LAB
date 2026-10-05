import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double sliderValue = 50;
  bool isEnabled = false;
  String selectedOption = 'Option 1';
  DateTime? selectedDate;

  Future<void> selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 - Input Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Slider',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Slider(
              value: sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: sliderValue.round().toString(),
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                });
              },
            ),

            Text('Slider value: ${sliderValue.round()}'),

            const SizedBox(height: 20),

            const Text(
              'Switch',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SwitchListTile(
              title: const Text('Enable feature'),
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  isEnabled = value;
                });
              },
            ),

            Text('Feature enabled: $isEnabled'),

            const SizedBox(height: 20),

            const Text(
              'Radio Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            RadioListTile<String>(
              title: const Text('Option 1'),
              value: 'Option 1',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),

            RadioListTile<String>(
              title: const Text('Option 2'),
              value: 'Option 2',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                });
              },
            ),

            Text('Selected: $selectedOption'),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: selectDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Select Date'),
            ),

            const SizedBox(height: 10),

            Text(
              selectedDate == null
                  ? 'No date selected'
                  : 'Selected date: '
                      '${selectedDate!.day}/'
                      '${selectedDate!.month}/'
                      '${selectedDate!.year}',
            ),
          ],
        ),
      ),
    );
  }
}