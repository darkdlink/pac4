import 'package:flutter/material.dart';
import 'package:beautycare_app/telas/tela_menu.dart'; // Importe a tela de menu
import 'package:beautycare_app/telas/tela_cadastro_cliente.dart'; // Importe a tela de cadastro de cliente

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Lista de clientes (ainda não há clientes cadastrados, mas simula a estrutura)
  List<String> clientes =
      []; // Lista vazia inicialmente, sem clientes cadastrados

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
        leading: GestureDetector(
          onTap: () {
            // Navega de volta para a TelaMenu
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaMenu()),
            );
          },
          child: Image.asset(
            'assets/imagens/logo.png', // Caminho da logo
            width: 100, // Largura da imagem
            height: 100, // Altura da imagem
            fit: BoxFit.contain, // Garante que a imagem mantenha proporções
          ),
        ),
        actions: const [
          // Removemos o botão de adicionar cliente da AppBar
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
              child: clientes.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhum cliente cadastrado",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: clientes.length,
                      itemBuilder: (context, indice) {
                        return ListTile(
                          leading: CircleAvatar(
                            // Usando a primeira letra do nome como inicial do avatar
                            child: Text(clientes[indice][0]),
                          ),
                          title: Text(clientes[indice]),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      // FloatingActionButton no canto inferior direito
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega para a tela de cadastro de cliente
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TelaCadastroCliente()),
          );
        },
        backgroundColor: const Color(0xFF966C5C),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
