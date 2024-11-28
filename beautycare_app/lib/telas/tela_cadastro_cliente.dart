import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TelaCadastroCliente extends StatefulWidget {
  const TelaCadastroCliente({super.key});

  @override
  State<TelaCadastroCliente> createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  // Variáveis para armazenar as respostas das perguntas
  bool? _tratamentoEstetico;
  bool? _temFilhos;
  bool? _amamentando;
  String? _intestino;
  String? _agua;
  String? _habitosAlimentares;
  bool? _intoleranciaAlimentar;
  bool? _bebidaAlcoolica;
  bool? _fuma;
  String? _sono;
  bool? _atividadeFisica;
  bool? _usaCosmeticos;
  bool? _alergiasIrritacoes;
  bool? _temQueloide;
  bool? _peleManchaFacilidade;
  bool? _temPatologias;
  bool? _temDisturbioHormonal;
  bool? _usaAnticoncepcional;
  bool? _usoAntidepressivo;
  bool? _deficienciaVitaminas;
  bool? _unhasCabelosFracos;

  // Controladores de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _escolaridadeController = TextEditingController();
  final TextEditingController _profissaoController = TextEditingController();
  final TextEditingController _estadoCivilController = TextEditingController();
  final TextEditingController _medicamentoController = TextEditingController();
  final TextEditingController _observacoesPeleController =
      TextEditingController();
  final TextEditingController _descricaoTratamentoController =
      TextEditingController();
  final TextEditingController _recomendacoesProdutosController =
      TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();

  // Variável para armazenar a imagem da cliente
  File? _image;

  // Controlador de imagem
  final ImagePicker _picker = ImagePicker();

  // Função para validar os campos obrigatórios
  bool _validarCampos() {
    if (_nomeController.text.isEmpty ||
        _dataNascimentoController.text.isEmpty) {
      return false;
    }
    return true;
  }

  // Função para pegar a imagem da galeria ou da câmera
  Future<void> _pickImage() async {
    // Exibe o diálogo para o usuário escolher entre tirar foto ou pegar da galeria
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha uma opção'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, ImageSource.camera);
            },
            child: const Text('Tirar Foto'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, ImageSource.gallery);
            },
            child: const Text('Escolher da Galeria'),
          ),
        ],
      ),
    );

    if (source != null) {
      // Pega a imagem com base na escolha do usuário
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Armazena a imagem selecionada
        });
      }
    }
  }

  // Função para construir um campo de texto que expande dinamicamente
  Widget _construirCampoTexto(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.multiline, // Permite múltiplas linhas
        maxLines: null, // Não limita o número de linhas
        minLines: 1, // O mínimo é uma linha
      ),
    );
  }

  // Função para construir um campo de data
  Widget _construirCampoData(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (selectedDate != null) {
            setState(() {
              controller.text = '${selectedDate.toLocal()}'.split(' ')[0];
            });
          }
        },
      ),
    );
  }

  // Função para construir perguntas com respostas Sim/Não
  Widget _construirPerguntaSimNao(String pergunta, bool? resposta) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(pergunta),
          const Spacer(),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: resposta,
                onChanged: (value) {
                  setState(() {
                    resposta = value;
                  });
                },
              ),
              const Text('Sim'),
              Radio<bool>(
                value: false,
                groupValue: resposta,
                onChanged: (value) {
                  setState(() {
                    resposta = value;
                  });
                },
              ),
              const Text('Não'),
            ],
          ),
        ],
      ),
    );
  }

  // Função para construir perguntas com múltiplas opções (RadioListTile)
  Widget _construirPerguntaOpcoes(
      String pergunta, List<String> opcoes, String? resposta) {
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
                      child: RadioListTile<String>(
                        title: Text(opcao),
                        value: opcao,
                        groupValue: resposta,
                        onChanged: (value) {
                          setState(() {
                            resposta = value;
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // Função para o botão de salvar com validação
  Widget _construirBotaoSalvar() {
    return ElevatedButton(
      onPressed: () {
        if (_validarCampos()) {
          // Aqui você pode navegar para outra tela ou salvar os dados
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cadastro concluído com sucesso!')));
        } else {
          // Exibe uma mensagem de erro
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Por favor, preencha todos os campos obrigatórios!')));
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20, // Menos padding para um botão menor
          vertical: 10, // Menor altura
        ),
        backgroundColor: const Color(0xFF966C5C), // Cor do botão
      ),
      child: const Text(
        'Salvar Cadastro',
        style: TextStyle(fontSize: 16), // Menor fonte
      ),
    );
  }

  // Controlador de rolagem
  final ScrollController _scrollController = ScrollController();

  // Função para rolar para o topo
  void _rolarParaTopo() {
    _scrollController.animateTo(
      0.0, // Rolando para o topo
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        title: const Text('Cadastro de Cliente'),
        backgroundColor: const Color(0xFFDB9B83),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Círculo de avatar, onde pode adicionar ou alterar a foto
              GestureDetector(
                onTap: _pickImage, // Ao clicar, abre a escolha de imagem
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(
                          _image!) // Se uma imagem for escolhida, exibe a imagem
                      : const AssetImage('assets/imagens/foto_cliente.png')
                          as ImageProvider, // Imagem padrão caso não tenha sido escolhida
                ),
              ),
              const SizedBox(height: 20),
              _construirCampoTexto('Nome', _nomeController),
              _construirCampoData(
                  'Data de Nascimento', _dataNascimentoController),
              _construirCampoTexto('Escolaridade', _escolaridadeController),
              _construirCampoTexto('Profissão', _profissaoController),
              _construirCampoTexto('Estado Civil', _estadoCivilController),
              const SizedBox(height: 20),
              const Text(
                'Consulta Avaliativa Integrativa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirPerguntaSimNao('Já realizou algum tratamento estético?',
                  _tratamentoEstetico),
              _construirPerguntaSimNao('Tem filhos?', _temFilhos),
              _construirPerguntaSimNao('Está amamentando?', _amamentando),
              _construirPerguntaOpcoes('Como funciona seu intestino',
                  ['Ótimo', 'Bom', 'Regular'], _intestino),
              _construirPerguntaOpcoes(
                  'Ingere água?', ['Muito', 'Médio', 'Pouco'], _agua),
              _construirPerguntaOpcoes('Hábitos alimentares?',
                  ['Saudável', 'Regular', 'Péssimo'], _habitosAlimentares),
              _construirPerguntaSimNao(
                  'Possui intolerância alimentar?', _intoleranciaAlimentar),
              _construirPerguntaSimNao(
                  'Ingere bebida alcoólica?', _bebidaAlcoolica),
              _construirPerguntaSimNao('Fuma?', _fuma),
              _construirPerguntaOpcoes(
                  'Como é o seu sono?', ['Bom', 'Regular', 'Ruim'], _sono),
              _construirPerguntaSimNao(
                  'Pratica atividade física?', _atividadeFisica),
              _construirPerguntaSimNao('Usa cosméticos?', _usaCosmeticos),
              _construirPerguntaSimNao(
                  'Tem alergias ou irritações?', _alergiasIrritacoes),
              _construirPerguntaSimNao('Tem queloide?', _temQueloide),
              _construirPerguntaSimNao(
                  'Pele mancha com facilidade?', _peleManchaFacilidade),
              _construirPerguntaSimNao('Tem patologias?', _temPatologias),
              _construirPerguntaSimNao(
                  'Tem distúrbio hormonal?', _temDisturbioHormonal),
              _construirPerguntaSimNao(
                  'Usa anticoncepcional?', _usaAnticoncepcional),
              _construirPerguntaSimNao(
                  'Uso de Antidepressivo?', _usoAntidepressivo),
              _construirCampoTexto(
                  'Faz uso de medicamento?', _medicamentoController),
              _construirPerguntaSimNao(
                  'Possui deficiência de vitaminas?', _deficienciaVitaminas),
              _construirPerguntaSimNao(
                  'Unhas e cabelos fracos?', _unhasCabelosFracos),
              const SizedBox(height: 20),
              const Text(
                'Avaliação da pele',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirCampoTexto(
                  'Observações sobre a pele', _observacoesPeleController),
              const SizedBox(height: 20),
              const Text(
                'Tratamento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirCampoTexto(
                  'Descrição do tratamento', _descricaoTratamentoController),
              const SizedBox(height: 20),
              const Text(
                'Produtos para usar em casa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _construirCampoTexto('Recomendações de produtos',
                  _recomendacoesProdutosController),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Seta que volta para o topo
                  IconButton(
                    icon: const Icon(Icons.arrow_upward),
                    onPressed: _rolarParaTopo,
                  ),
                  // Botão de salvar
                  _construirBotaoSalvar(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
