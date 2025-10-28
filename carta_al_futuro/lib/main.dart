import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const CartaAlFuturoApp());
}

class CartaAlFuturoApp extends StatelessWidget {
  const CartaAlFuturoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carta al Futuro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const LoginScreen(),
    );
  }
}
