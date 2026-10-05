import 'package:flutter/material.dart';

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({super.key});

  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode
          ? ThemeData.dark()
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
              ),
              useMaterial3: true,
            ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Exercise 4 - Scaffold'),
              actions: [
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ],
            ),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.flutter_dash,
                    size: 80,
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    'Flutter UI Demo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    isDarkMode
                        ? 'Dark Mode is ON'
                        : 'Light Mode is ON',
                  ),
                ],
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('FAB pressed!'),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}