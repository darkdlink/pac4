import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class TelaCadastroCliente extends StatefulWidget {
  final Map<String, dynamic>? cliente;

  const TelaCadastroCliente({Key? key, this.cliente}) : super(key: key);

  @override
  State<TelaCadastroCliente> createState() => _TelaCadastroClienteState();
}

class _TelaCadastroClienteState extends State<TelaCadastroCliente> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  // Controladores de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();
  final TextEditingController _escolaridadeController = TextEditingController();
  final TextEditingController _profissaoController = TextEditingController();
  final TextEditingController _estadoCivilController = TextEditingController();
  final TextEditingController _tratamentoController = TextEditingController();
  final TextEditingController _intoleranciaAlimentarController =
      TextEditingController();
  final TextEditingController _cosmeticosController = TextEditingController();
  final TextEditingController _alergiasController = TextEditingController();
  final TextEditingController _patologiasController = TextEditingController();
  final TextEditingController _disturbioHormonalController =
      TextEditingController();
  final TextEditingController _medicamentoController = TextEditingController();
  final TextEditingController _deficienciaVitaminasController =
      TextEditingController();
  final TextEditingController _avaliacaoPeleController =
      TextEditingController();
  final TextEditingController _tratamentoPeleController =
      TextEditingController();
  final TextEditingController _produtosCasaController = TextEditingController();

  // Variáveis para perguntas booleanas e escolhas
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

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.cliente != null) {
      // Preenche os controladores com os dados existentes
      _nomeController.text = widget.cliente!['nome'] ?? '';
      _dataNascimentoController.text = widget.cliente!['data_nascimento'] ?? '';
      _escolaridadeController.text = widget.cliente!['escolaridade'] ?? '';
      _profissaoController.text = widget.cliente!['profissao'] ?? '';
      _estadoCivilController.text = widget.cliente!['estado_civil'] ?? '';
      _tratamentoEstetico = widget.cliente!['tratamento_estetico'];
      _tratamentoController.text =
          widget.cliente!['tratamento_estetico_descricao'] ?? '';
      _temFilhos = widget.cliente!['tem_filhos'];
      _amamentando = widget.cliente!['amamentando'];
      _intestino = widget.cliente!['intestino'];
      _agua = widget.cliente!['ingere_agua'];
      _habitosAlimentares = widget.cliente!['habitos_alimentares'];
      _intoleranciaAlimentar = widget.cliente!['intolerancia_alimentar'];
      _intoleranciaAlimentarController.text =
          widget.cliente!['intolerancia_alimentar_descricao'] ?? '';
      _bebidaAlcoolica = widget.cliente!['ingere_bebida_alcoolica'];
      _fuma = widget.cliente!['fuma'];
      _sono = widget.cliente!['sono'];
      _atividadeFisica = widget.cliente!['atividade_fisica'];
      _cosmeticosController.text =
          widget.cliente!['usa_cosmeticos_descricao'] ?? '';
      _alergiasController.text =
          widget.cliente!['alergias_irritacoes_descricao'] ?? '';
      _patologiasController.text =
          widget.cliente!['tem_patologias_descricao'] ?? '';
      _disturbioHormonalController.text =
          widget.cliente!['tem_disturbio_hormonal_descricao'] ?? '';
      _medicamentoController.text =
          widget.cliente!['uso_medicamento_descricao'] ?? '';
      _deficienciaVitaminasController.text =
          widget.cliente!['deficiencia_vitaminas_descricao'] ?? '';
      _avaliacaoPeleController.text = widget.cliente!['avaliacao_pele'] ?? '';
      _tratamentoPeleController.text = widget.cliente!['tratamento'] ?? '';
      _produtosCasaController.text =
          widget.cliente!['produtos_para_casa'] ?? '';
    }
  }

  // Função para selecionar imagem
  Future<void> _pickImage() async {}

  // Função para salvar o cadastro no Supabase
  Future<void> _salvarCadastro() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (widget.cliente == null) {
          // Inserção de novo cliente
          await Supabase.instance.client.from('cliente').insert({
            'nome': _nomeController.text,
            'data_nascimento': _dataNascimentoController.text,
            'escolaridade': _escolaridadeController.text,
            'profissao': _profissaoController.text,
            'estado_civil': _estadoCivilController.text,
            'tratamento_estetico': _tratamentoEstetico,
            'tratamento_estetico_descricao': _tratamentoController.text,
            'tem_filhos': _temFilhos,
            'amamentando': _amamentando,
            'intestino': _intestino,
            'ingere_agua': _agua,
            'habitos_alimentares': _habitosAlimentares,
            'intolerancia_alimentar': _intoleranciaAlimentar,
            'intolerancia_alimentar_descricao':
                _intoleranciaAlimentarController.text,
            'ingere_bebida_alcoolica': _bebidaAlcoolica,
            'fuma': _fuma,
            'sono': _sono,
            'atividade_fisica': _atividadeFisica,
            'usa_cosmeticos_descricao': _cosmeticosController.text,
            'alergias_irritacoes_descricao': _alergiasController.text,
            'tem_patologias_descricao': _patologiasController.text,
            'tem_disturbio_hormonal_descricao':
                _disturbioHormonalController.text,
            'uso_medicamento_descricao': _medicamentoController.text,
            'deficiencia_vitaminas_descricao':
                _deficienciaVitaminasController.text,
            'avaliacao_pele': _avaliacaoPeleController.text,
            'tratamento': _tratamentoPeleController.text,
            'produtos_para_casa': _produtosCasaController.text,
          });
        } else {
          // Atualização de cliente existente
          await Supabase.instance.client.from('cliente').update({
            'nome': _nomeController.text,
            'data_nascimento': _dataNascimentoController.text,
            'escolaridade': _escolaridadeController.text,
            'profissao': _profissaoController.text,
            'estado_civil': _estadoCivilController.text,
            'tratamento_estetico': _tratamentoEstetico,
            'tratamento_estetico_descricao': _tratamentoController.text,
            'tem_filhos': _temFilhos,
            'amamentando': _amamentando,
            'intestino': _intestino,
            'ingere_agua': _agua,
            'habitos_alimentares': _habitosAlimentares,
            'intolerancia_alimentar': _intoleranciaAlimentar,
            'intolerancia_alimentar_descricao':
                _intoleranciaAlimentarController.text,
            'ingere_bebida_alcoolica': _bebidaAlcoolica,
            'fuma': _fuma,
            'sono': _sono,
            'atividade_fisica': _atividadeFisica,
            'usa_cosmeticos_descricao': _cosmeticosController.text,
            'alergias_irritacoes_descricao': _alergiasController.text,
            'tem_patologias_descricao': _patologiasController.text,
            'tem_disturbio_hormonal_descricao':
                _disturbioHormonalController.text,
            'uso_medicamento_descricao': _medicamentoController.text,
            'deficiencia_vitaminas_descricao':
                _deficienciaVitaminasController.text,
            'avaliacao_pele': _avaliacaoPeleController.text,
            'tratamento': _tratamentoPeleController.text,
            'produtos_para_casa': _produtosCasaController.text,
          }).eq('id', widget.cliente!['id']);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cadastro salvo com sucesso!')),
          );
          Navigator.pop(context, {
            // Retorna os dados atualizados
            ...widget.cliente ?? {},
            'nome': _nomeController.text,
            'data_nascimento': _dataNascimentoController.text,
            'escolaridade': _escolaridadeController.text,
            'profissao': _profissaoController.text,
            'estado_civil': _estadoCivilController.text,
            'tratamento_estetico': _tratamentoEstetico,
            'tratamento_estetico_descricao': _tratamentoController.text,
            'tem_filhos': _temFilhos,
            'amamentando': _amamentando,
            'intestino': _intestino,
            'ingere_agua': _agua,
            'habitos_alimentares': _habitosAlimentares,
            'intolerancia_alimentar': _intoleranciaAlimentar,
            'intolerancia_alimentar_descricao':
                _intoleranciaAlimentarController.text,
            'ingere_bebida_alcoolica': _bebidaAlcoolica,
            'fuma': _fuma,
            'sono': _sono,
            'atividade_fisica': _atividadeFisica,
            'usa_cosmeticos_descricao': _cosmeticosController.text,
            'alergias_irritacoes_descricao': _alergiasController.text,
            'tem_patologias_descricao': _patologiasController.text,
            'tem_disturbio_hormonal_descricao':
                _disturbioHormonalController.text,
            'uso_medicamento_descricao': _medicamentoController.text,
            'deficiencia_vitaminas_descricao':
                _deficienciaVitaminasController.text,
            'avaliacao_pele': _avaliacaoPeleController.text,
            'tratamento': _tratamentoPeleController.text,
            'produtos_para_casa': _produtosCasaController.text,
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao salvar cliente: $e')),
          );
        }
      }
    }
  }

  // Construção da interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.cliente == null ? 'Cadastro de Cliente' : 'Editar Cliente'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Sai sem salvar
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              children: [
                // Implementação do campo de foto se desejar

                // Perguntas de Identificação
                _buildTextField('Nome Completo', _nomeController),
                _buildDatePickerField(
                    'Data de Nascimento', _dataNascimentoController),
                _buildTextField('Escolaridade', _escolaridadeController),
                _buildTextField('Profissão', _profissaoController),
                _buildTextField('Estado Civil', _estadoCivilController),

                // Perguntas de Avaliação
                _buildBooleanQuestion(
                  'Já realizou algum tratamento estético?',
                  _tratamentoEstetico,
                  onChanged: (value) =>
                      setState(() => _tratamentoEstetico = value),
                  hasTextField: true,
                  textController: _tratamentoController,
                ),
                _buildBooleanQuestion(
                  'Tem filhos?',
                  _temFilhos,
                  onChanged: (value) => setState(() => _temFilhos = value),
                ),
                _buildBooleanQuestion(
                  'Está amamentando?',
                  _amamentando,
                  onChanged: (value) => setState(() => _amamentando = value),
                ),
                _buildRadioQuestion(
                  'Como funciona seu intestino?',
                  ['Ótimo', 'Bom', 'Regular'],
                  selectedValue: _intestino,
                  onChanged: (value) => setState(() => _intestino = value),
                ),
                _buildRadioQuestion(
                  'Ingere água?',
                  ['Muito', 'Médio', 'Pouco'],
                  selectedValue: _agua,
                  onChanged: (value) => setState(() => _agua = value),
                ),
                _buildRadioQuestion(
                  'Hábitos alimentares?',
                  ['Saudável', 'Regular', 'Péssimo'],
                  selectedValue: _habitosAlimentares,
                  onChanged: (value) =>
                      setState(() => _habitosAlimentares = value),
                ),
                _buildBooleanQuestion(
                  'Possui intolerância alimentar?',
                  _intoleranciaAlimentar,
                  onChanged: (value) =>
                      setState(() => _intoleranciaAlimentar = value),
                  hasTextField: true,
                  textController: _intoleranciaAlimentarController,
                ),
                _buildBooleanQuestion(
                  'Ingere bebida alcoólica?',
                  _bebidaAlcoolica,
                  onChanged: (value) =>
                      setState(() => _bebidaAlcoolica = value),
                ),
                _buildBooleanQuestion(
                  'Fuma?',
                  _fuma,
                  onChanged: (value) => setState(() => _fuma = value),
                ),
                _buildRadioQuestion(
                  'Como é o seu sono?',
                  ['Bom', 'Regular', 'Ruim'],
                  selectedValue: _sono,
                  onChanged: (value) => setState(() => _sono = value),
                ),
                _buildBooleanQuestion(
                  'Pratica atividade física?',
                  _atividadeFisica,
                  onChanged: (value) =>
                      setState(() => _atividadeFisica = value),
                ),
                _buildTextField('Avaliação da pele', _avaliacaoPeleController),
                _buildTextField('Tratamento', _tratamentoPeleController),
                _buildTextField(
                    'Produtos para usar em casa', _produtosCasaController),

                // Botão de Salvar
                ElevatedButton(
                  onPressed: _salvarCadastro,
                  child: const Text('Salvar Cadastro'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: controller.text.isNotEmpty
                ? DateFormat('yyyy-MM-dd').parse(controller.text)
                : DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (selectedDate != null) {
            controller.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildBooleanQuestion(
    String question,
    bool? value, {
    required ValueChanged<bool?> onChanged,
    bool hasTextField = false,
    TextEditingController? textController,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Sim'),
                  value: true,
                  groupValue: value,
                  onChanged: onChanged,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Não'),
                  value: false,
                  groupValue: value,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
          if (hasTextField && value == true && textController != null)
            _buildTextField('Descrição', textController),
        ],
      ),
    );
  }

  Widget _buildRadioQuestion(
    String question,
    List<String> options, {
    required String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          ...options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedValue,
              onChanged: onChanged,
            );
          }).toList(),
        ],
      ),
    );
  }
}
