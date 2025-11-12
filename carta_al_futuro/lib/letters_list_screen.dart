import 'package:flutter/material.dart';
import 'db_helper.dart';

class LettersListScreen extends StatefulWidget {
  const LettersListScreen({super.key});

  @override
  State<LettersListScreen> createState() => _LettersListScreenState();
}

class _LettersListScreenState extends State<LettersListScreen> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _letters = [];

  @override
  void initState() {
    super.initState();
    _loadLetters();
  }

  void _loadLetters() async {
    final db = await dbHelper.database;
    final letters = await db.query('letters', orderBy: 'id DESC');
    setState(() {
      _letters = letters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cartas guardadas")),
      body: _letters.isEmpty
          ? const Center(child: Text("No hay cartas guardadas aún."))
          : ListView.builder(
              itemCount: _letters.length,
              itemBuilder: (context, index) {
                final letter = _letters[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(letter['text'], maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text("Para: ${letter['email']} — ${letter['deliveryTime']}"),
                    trailing: Text(letter['dateCreated'].toString().split('.')[0]),
                  ),
                );
              },
            ),
    );
  }
}
