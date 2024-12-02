import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'tela_menu.dart';
import 'tela_cadastro_cliente.dart';
import 'tela_cliente.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  // Lista de clientes
  List<Map<String, dynamic>> clientes = [];
  List<Map<String, dynamic>> clientesFiltrados = [];

  final TextEditingController _controladorPesquisa = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    try {
      final data = await Supabase.instance.client.from('cliente').select();

      setState(() {
        clientes = List<Map<String, dynamic>>.from(data);
        clientesFiltrados = clientes;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar clientes: $e')),
        );
      }
    }
  }

  Future<void> _excluirCliente(int id) async {
    try {
      await Supabase.instance.client.from('cliente').delete().eq('id', id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente excluído com sucesso!')),
        );
      }

      // Recarrega a lista de clientes após a exclusão
      await _carregarClientes();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir cliente: $e')),
        );
      }
    }
  }

  void _filtrarClientes(String texto) {
    setState(() {
      clientesFiltrados = clientes.where((cliente) {
        final nome = cliente['nome'] ?? '';
        return nome.toLowerCase().contains(texto.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDB9B83),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB9B83),
        elevation: 0,
        toolbarHeight: 120,
        leadingWidth: 150,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaMenu()),
            );
          },
          child: Image.asset(
            'assets/imagens/logo.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controladorPesquisa,
              onChanged: _filtrarClientes,
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
              color: const Color(0xFFD09A81),
              child: clientesFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhum cliente cadastrado",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: clientesFiltrados.length,
                      itemBuilder: (context, indice) {
                        final cliente = clientesFiltrados[indice];
                        final imagemUrl = cliente['imagem_url'];
                        final nome = cliente['nome'] ?? 'Sem nome';
                        final id = cliente['id'];

                        return ListTile(
                          leading: imagemUrl != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(imagemUrl),
                                )
                              : const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                          title: Text(
                            nome,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TelaCliente(cliente: cliente),
                              ),
                            );
                            // Recarrega a lista de clientes ao retornar
                            _carregarClientes();
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Confirmação antes de excluir
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirmar exclusão'),
                                  content: Text(
                                      'Deseja realmente excluir o cliente "$nome"?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _excluirCliente(id);
                                      },
                                      child: const Text('Excluir'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navega para a tela de cadastro e recarrega os clientes ao voltar
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TelaCadastroCliente()),
          );
          if (mounted) {
            await _carregarClientes();
          }
        },
        backgroundColor: const Color(0xFF966C5C),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
