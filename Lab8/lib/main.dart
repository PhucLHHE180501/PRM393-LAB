import 'package:flutter/material.dart';
import 'models/post.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8 Networking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PostListScreen(),
    );
  }
}

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    setState(() {
      _futurePosts = _apiService.fetchPosts();
    });
  }

  void _showAddPostDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
                try {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating post...')),
                  );
                  final newPost = await _apiService.createPost(
                      titleController.text, bodyController.text);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Created successfully: ID ${newPost.id}')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                }
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('Lab 8 - API List Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchData,
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _fetchData,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  )
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            if (posts.isEmpty) {
              return const Center(child: Text('No posts available.'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                _fetchData();
                await _futurePosts;
              },
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(post.id.toString()),
                      ),
                      title: Text(
                        post.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () {
                        // Detail Screen equivalent inside dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(post.title),
                            content: SingleChildScrollView(child: Text(post.body)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPostDialog,
        tooltip: 'Add Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}