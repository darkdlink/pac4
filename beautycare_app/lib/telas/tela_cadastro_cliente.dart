import 'package:flutter/material.dart';

class TelaCadastroCliente extends StatefulWidget {
  const TelaCadastroCliente({super.key});

  @override
  State<TelaCadastroCliente> createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
        backgroundColor: const Color(0xFFDB9B83),
      ),
      body: SingleChildScrollView(
        //rolagem da tela
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Estica os elementos horiz
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/imagens/foto_cliente.png'),
                ),
              ),
              const SizedBox(height: 20),
              // Campos da ficha de anamnese
              _construirCampoTexto('Nome'),
              _construirCampoData('Data de Nascimento'),
              _construirCampoTexto('Escolaridade'),
              _construirCampoTexto('Profissão'),
              _construirCampoTexto('Estado Civil'),
              const SizedBox(height: 20),
              const Text(
                'Consulta Avaliativa Integrativa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirPerguntaSimNao(
                  'Já realizou algum tratamento estético?'),
              _construirPerguntaSimNao('Tem filhos?'),
              _construirPerguntaSimNao('Está amamentando?'),
              _construirPerguntaOpcoes(
                  'Como funciona seu intestino', ['Ótimo', 'Bom', 'Regular']),
              _construirPerguntaOpcoes(
                  'Ingere água?', ['Muito', 'Médio', 'Pouco']),
              _construirPerguntaOpcoes(
                  'Hábitos alimentares?', ['Saudável', 'Regular', 'Péssimo']),
              _construirPerguntaSimNao('Possui intolerância alimentar?'),
              _construirPerguntaSimNao('Ingere bebida alcoólica?'),
              _construirPerguntaSimNao('Fuma?'),
              _construirPerguntaOpcoes(
                  'Como é o seu sono?', ['Bom', 'Regular', 'Ruim']),
              _construirPerguntaSimNao('Pratica atividade física?'),
              _construirPerguntaSimNao('Usa cosméticos?'),
              _construirPerguntaSimNao('Tem alergias ou irritações?'),
              _construirPerguntaSimNao('Tem queloide?'),
              _construirPerguntaSimNao('Pele mancha com facilidade?'),
              _construirPerguntaSimNao('Tem patologias?'),
              _construirPerguntaSimNao('Tem distúrbio hormonal?'),
              _construirPerguntaSimNao('Usa anticoncepcional?'),
              _construirPerguntaSimNao('Uso de Antidepressivo?'),
              _construirCampoTexto('Faz uso de medicamento?'),
              _construirPerguntaSimNao('Possui deficiência de vitaminas?'),
              _construirPerguntaSimNao('Unhas e cabelos fracos?'),
              const SizedBox(height: 20),
              const Text(
                'Avaliação da pele',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirCampoTexto('Observações sobre a pele'),
              const SizedBox(height: 20),
              const Text(
                'Tratamento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirCampoTexto('Descrição do tratamento'),
              const SizedBox(height: 20),
              const Text(
                'Produtos para usar em casa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirCampoTexto('Recomendações de produtos'),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Função: construir um campo de texto
  Widget _construirCampoTexto(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Função:construir um campo de data
  Widget _construirCampoData(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          // Ação para selecionar a data tem que descobrir como implementar
        },
      ),
    );
  }

  // Função:construir uma pergunta com opções Sim/Não
  Widget _construirPerguntaSimNao(String pergunta) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(pergunta),
          const Spacer(), //  opções para a direita
          const Row(
            children: [
              Radio(value: true, groupValue: null, onChanged: null),
              Text('Sim'),
              Radio(value: false, groupValue: null, onChanged: null),
              Text('Não'),
            ],
          ),
        ],
      ),
    );
  }

  // Função:construir uma pergunta com múltiplas opções
  Widget _construirPerguntaOpcoes(String pergunta, List<String> opcoes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pergunta),
          const SizedBox(height: 8),
          Wrap(
            children: opcoes
                .map((opcao) => Expanded(
                      child: RadioListTile(
                        title: Text(opcao),
                        value: opcao,
                        groupValue: null,
                        onChanged: null,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
