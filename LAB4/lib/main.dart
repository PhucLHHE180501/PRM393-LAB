import 'package:flutter/material.dart';
import 'debug_fix_demo.dart';
import 'core_widgets_demo.dart';
import 'input_controls_demo.dart';
import 'layout_demo.dart';
import 'scaffold_demo.dart';

void main() {
  runApp(const Lab4App());
}

class Lab4App extends StatelessWidget {
  const Lab4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Flutter UI Fundamentals',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData.dark(),

      themeMode: ThemeMode.light,

      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 - Flutter UI'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Flutter UI Fundamentals',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CoreWidgetsDemo(),
                ),
              );
            },
            child: const Text('Exercise 1 - Core Widgets'),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InputControlsDemo(),
                ),
              );
            },
            child: const Text('Exercise 2 - Input Widgets'),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LayoutDemo(),
                ),
              );
            },
            child: const Text('Exercise 3 - Layout'),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ScaffoldDemo(),
                ),
              );
            },
            child: const Text('Exercise 4 - Scaffold & Theme'),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DebugFixDemo(),
                ),
              );
            },
            child: const Text('Exercise 5 - Debug & Fix'),
          ),
        ],
      ),
    );
  }
}