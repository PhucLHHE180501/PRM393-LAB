import 'package:flutter/material.dart';

class DebugFixDemo extends StatefulWidget {
  const DebugFixDemo({super.key});

  @override
  State<DebugFixDemo> createState() => _DebugFixDemoState();
}

class _DebugFixDemoState extends State<DebugFixDemo> {
  bool isEnabled = false;
  DateTime? selectedDate;

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 - Debug & Fix'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Common UI Fixes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              '1. ListView inside Column is fixed using Expanded.',
            ),

            const SizedBox(height: 16),

            const Text(
              '2. Small-screen overflow is fixed using '
              'SingleChildScrollView.',
            ),

            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text('3. State Update'),
              subtitle: Text('Enabled: $isEnabled'),
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  isEnabled = value;
                });
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: chooseDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text('4. Open DatePicker'),
            ),

            const SizedBox(height: 12),

            Text(
              selectedDate == null
                  ? 'No date selected'
                  : 'Selected: '
                      '${selectedDate!.day}/'
                      '${selectedDate!.month}/'
                      '${selectedDate!.year}',
            ),

            const SizedBox(height: 300),

            const Text(
              'This screen demonstrates the fixes required '
              'in Exercise 5.',
            ),
          ],
        ),
      ),
    );
  }
}