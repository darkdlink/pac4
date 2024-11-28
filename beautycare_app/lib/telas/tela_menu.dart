import 'package:flutter/material.dart';
import 'package:beautycare_app/telas/tela_cadastro.dart'; // Importe a tela de cadastro
import 'package:beautycare_app/telas/tela_aniversario.dart'; // Importe a tela de aniversário
import 'package:beautycare_app/telas/tela_login.dart'; // Importe a tela de login (caso o logout redirecione para ela)

class TelaMenu extends StatelessWidget {
  const TelaMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDB9B83),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB9B83),
        elevation: 0, // Remove a sombra
        toolbarHeight: 120, // Aumenta a altura da AppBar
        leadingWidth: 150, // Ajusta a largura do espaço do leading
        leading: Padding(
          padding: const EdgeInsets.all(0.0), // Espaçamento ao redor da imagem
          child: Image.asset(
            'assets/imagens/logo.png', // Caminho da logo
            width: 100, // Largura da imagem
            height: 100, // Altura da imagem
            fit: BoxFit.contain, // Garante que a imagem mantenha proporções
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, size: 30), // Ícone de logout
            onPressed: () {
              // Redireciona para a tela de login quando o botão de logout for pressionado
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TelaLogin()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botão Cadastro
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF966C5C),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {
                // Navega para a tela de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaCadastro()),
                );
              },
              child: const Text('Cadastro'),
            ),
            const SizedBox(height: 30), // Espaço entre os botões
            // Botão Aniversário
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF966C5C),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {
                // Navega para a tela de aniversário
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TelaAniversario()),
                );
              },
              child: const Text('Aniversário'),
            ),
          ],
        ),
      ),
    );
  }
}
