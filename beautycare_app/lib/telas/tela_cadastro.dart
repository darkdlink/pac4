import 'package:flutter/material.dart';
import 'package:beautycare_app/telas/tela_cadastro_cliente.dart'; // Importe a tela de cadastro de cliente

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Lista de clientes (ver como fazer depois)
  List<String> clientes = [];
  // Campo de pesquisa
  final TextEditingController _controladorPesquisa = TextEditingController();

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
            icon: const Icon(Icons.person_add),
            onPressed: () {
              // Navega para a tela de cadastro de cliente
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TelaCadastroCliente()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorPesquisa,
              onChanged: (texto) {
                // Filtrar a lista de clientes
                setState(() {
                  // Atualiza a lista de clientes visível
                  clientes = clientes
                      .where((cliente) =>
                          cliente.toLowerCase().contains(texto.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Pesquisar cliente',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFD09A81), // Cor de fundo da lista
              child: ListView.builder(
                itemCount: clientes.length,
                itemBuilder: (context, indice) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Text('A'),
                    ),
                    title: Text(clientes[indice]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
