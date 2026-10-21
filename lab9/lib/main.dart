
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const Lab9App());
}

class Lab9App extends StatelessWidget {
  const Lab9App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 9 - JSON Storage',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ================= HOME SCREEN =================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LAB 9 - Local JSON Storage'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile(
            context,
            'Lab 9.1',
            'Read JSON From Assets',
            const AssetsScreen(),
          ),
          _tile(
            context,
            'Lab 9.2',
            'Save & Load JSON From Storage',
            const StorageScreen(),
          ),
          _tile(
            context,
            'Lab 9.3',
            'CRUD + Search + Auto Save',
            const CrudScreen(),
          ),
        ],
      ),
    );
  }

  Widget _tile(
      BuildContext context,
      String title,
      String subtitle,
      Widget screen,
      ) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}

// ================= LAB 9.1 =================
// READ JSON FROM ASSETS

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  List<Map<String, dynamic>> items = [];
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final raw = await rootBundle.loadString(
        'assets/data/students.json',
      );

      final parsed = (jsonDecode(raw) as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      if (mounted) {
        setState(() {
          items = parsed;
          error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => error = '$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.1 - Read Assets'),
      ),
      body: error != null
          ? Center(child: Text('Error: $error'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${items[i]['id']}'),
              ),
              title: Text('${items[i]['name']}'),
              subtitle: Text('${items[i]['email']}'),
            ),
          );
        },
      ),
    );
  }
}

// ================= JSON STORAGE SERVICE =================

class JsonStorage {
  final String filename;

  JsonStorage(this.filename);

  Future<File> _file() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  Future<List<Map<String, dynamic>>> load() async {
    final file = await _file();

    if (!await file.exists()) {
      await file.writeAsString('[]');
      return [];
    }

    final content = await file.readAsString();

    if (content.trim().isEmpty) {
      return [];
    }

    return (jsonDecode(content) as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }

  Future<void> save(List<Map<String, dynamic>> items) async {
    final file = await _file();

    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(items),
      flush: true,
    );
  }
}

// ================= LAB 9.2 =================
// SAVE AND LOAD JSON

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final storage = JsonStorage('lab9_2.json');
  final controller = TextEditingController();

  List<Map<String, dynamic>> items = [];
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final data = await storage.load();

      if (mounted) {
        setState(() {
          items = data;
          error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => error = '$e');
      }
    }
  }

  void _add() {
    final name = controller.text.trim();

    if (name.isEmpty) return;

    setState(() {
      final nextId = items.fold<int>(
        0,
            (maxId, e) =>
        (e['id'] as int) > maxId ? e['id'] as int : maxId,
      ) + 1;

      items.add({
        'id': nextId,
        'name': name,
      });
    });

    controller.clear();
  }

  Future<void> _save() async {
    try {
      await storage.save(items);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã lưu JSON thành công!'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi lưu: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.2 - Save & Load'),
        actions: [
          IconButton(
            onPressed: _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Tên mục mới',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _add,
                  child: const Text('Thêm'),
                ),
              ],
            ),
          ),
          if (error != null) Text('Lỗi: $error'),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                return ListTile(
                  leading: const Icon(Icons.note),
                  title: Text('${items[i]['name']}'),
                  subtitle: Text('ID: ${items[i]['id']}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Lưu vào JSON'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= LAB 9.3 =================
// CRUD + SEARCH + AUTO SAVE

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final storage = JsonStorage('lab9_3.json');
  final search = TextEditingController();

  List<Map<String, dynamic>> items = [];
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
    search.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _load() async {
    try {
      final data = await storage.load();

      if (mounted) {
        setState(() {
          items = data;
          error = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => error = '$e');
      }
    }
  }

  Future<void> _persist() async {
    try {
      await storage.save(items);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không lưu được: $e')),
        );
      }
    }
  }

  // Add and Edit
  Future<void> _edit([Map<String, dynamic>? existing]) async {
    final name = TextEditingController(
      text: existing?['name']?.toString() ?? '',
    );

    final email = TextEditingController(
      text: existing?['email']?.toString() ?? '',
    );

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            existing == null ? 'Thêm nhân viên' : 'Sửa nhân viên',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  labelText: 'Họ tên',
                ),
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () {
                if (name.text.trim().isEmpty) return;

                Navigator.pop(ctx, {
                  'name': name.text.trim(),
                  'email': email.text.trim(),
                });
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );

    name.dispose();
    email.dispose();

    if (result == null || !mounted) return;

    setState(() {
      if (existing == null) {
        final nextId = items.fold<int>(
          0,
              (maxId, e) =>
          (e['id'] as int) > maxId ? e['id'] as int : maxId,
        ) + 1;

        items.add({
          'id': nextId,
          ...result,
        });
      } else {
        existing.addAll(result);
      }
    });

    await _persist();
  }

  // Delete
  Future<void> _delete(Map<String, dynamic> item) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Xác nhận xóa'),
          content: Text('Xóa ${item['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Xóa'),
            ),
          ],
        );
      },
    );

    if (yes != true || !mounted) return;

    setState(() {
      items.remove(item);
    });

    await _persist();
  }

  @override
  void dispose() {
    search.removeListener(_refresh);
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyword = search.text.trim().toLowerCase();

    final filtered = items.where((e) {
      return '${e['name']} ${e['email']}'
          .toLowerCase()
          .contains(keyword);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 9.3 - CRUD + Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Tìm theo tên hoặc email',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          if (error != null) Text('Lỗi: $error'),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
              child: Text('Không có dữ liệu'),
            )
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final item = filtered[i];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${item['id']}'),
                    ),
                    title: Text('${item['name']}'),
                    subtitle: Text('${item['email']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Sửa',
                          onPressed: () => _edit(item),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          tooltip: 'Xóa',
                          onPressed: () => _delete(item),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(),
        icon: const Icon(Icons.add),
        label: const Text('Thêm'),
      ),
    );
  }
}
