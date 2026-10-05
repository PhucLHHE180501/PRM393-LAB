import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  final List<String> movies = const [
    'Avengers: Endgame',
    'Spider-Man: No Way Home',
    'Your Name',
    'Demon Slayer',
    'One Piece Film Red',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 - Layout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Movies',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.movie),
                const SizedBox(width: 8),
                Text(
                  '${movies.length} movies',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text(
              'Movie List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(movies[index]),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}