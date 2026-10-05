import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 - Core Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutter UI Fundamentals',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Icon(
              Icons.flutter_dash,
              size: 60,
            ),

            const SizedBox(height: 16),

            Image.network(
              'https://picsum.photos/600/250',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Movie Item'),
                subtitle: const Text('This is a ListTile inside a Card.'),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}