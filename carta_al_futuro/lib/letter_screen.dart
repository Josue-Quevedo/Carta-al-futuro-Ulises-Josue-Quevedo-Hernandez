import 'package:flutter/material.dart';
import 'db_helper.dart';

class LetterScreen extends StatefulWidget {
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  final TextEditingController _letterController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedTime = "6 meses";

  final dbHelper = DatabaseHelper.instance;

  void _sendLetter() async {
    final text = _letterController.text.trim();
    final email = _emailController.text.trim();

    if (text.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    await dbHelper.insertLetter({
      'text': text,
      'email': email,
      'deliveryTime': _selectedTime,
      'dateCreated': DateTime.now().toString(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Carta enviada con éxito")),
    );

    _letterController.clear();
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carta al futuro")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _letterController,
              maxLength: 500,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Escribe tu carta (máx. 500 caracteres)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Correo de destino",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedTime,
              items: const [
                DropdownMenuItem(value: "6 meses", child: Text("6 meses")),
                DropdownMenuItem(value: "1 año", child: Text("1 año")),
                DropdownMenuItem(value: "2 años", child: Text("2 años")),
              ],
              onChanged: (value) {
                setState(() => _selectedTime = value!);
              },
              decoration: const InputDecoration(
                labelText: "Tiempo de entrega",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendLetter,
              child: const Text("Enviar carta"),
            ),
          ],
        ),
      ),
    );
  }
}
