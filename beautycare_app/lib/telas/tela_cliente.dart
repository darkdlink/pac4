import 'package:flutter/material.dart';

class TelaCliente extends StatelessWidget {
  // Parâmetros para exibir as informações do cliente
  final String nome;
  final String dataNascimento;
  final String escolaridade;
  final String profissao;
  final String estadoCivil;

  const TelaCliente({
    super.key,
    required this.nome,
    required this.dataNascimento,
    required this.escolaridade,
    required this.profissao,
    required this.estadoCivil,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDB9B83),
        title: const Text('Informações do Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Exibe os dados do cliente
            _construirInformacao('Nome', nome),
            _construirInformacao('Data de Nascimento', dataNascimento),
            _construirInformacao('Escolaridade', escolaridade),
            _construirInformacao('Profissão', profissao),
            _construirInformacao('Estado Civil', estadoCivil),
          ],
        ),
      ),
    );
  }

  // Função para criar uma linha com o nome do campo e o valor
  Widget _construirInformacao(String campo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$campo: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(valor),
          ),
        ],
      ),
    );
  }
}
