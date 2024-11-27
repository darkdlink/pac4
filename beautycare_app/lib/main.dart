import 'package:flutter/material.dart';
import 'package:beautycare_app/telas/tela_login.dart'; // Importa a tela de login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaLogin(), // Define a TelaLogin como a tela inicial
    );
  }
}
