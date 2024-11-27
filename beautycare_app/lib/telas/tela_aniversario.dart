import 'package:flutter/material.dart';

class TelaAniversario extends StatelessWidget {
  const TelaAniversario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de 1  Aniversário'),
      ),
      body: const Center(
        child: Text('Em breve, a tela de aniversário!'),
      ),
    );
  }
}
