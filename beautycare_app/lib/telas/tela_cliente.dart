import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'tela_cadastro_cliente.dart'; // Importa a tela de cadastro e tambem edição

class TelaCliente extends StatefulWidget {
  final Map<String, dynamic> cliente;

  const TelaCliente({Key? key, required this.cliente}) : super(key: key);

  @override
  _TelaClienteState createState() => _TelaClienteState();
}

class _TelaClienteState extends State<TelaCliente> {
  late Map<String, dynamic> cliente;

  @override
  void initState() {
    super.initState();
    cliente = widget.cliente;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações de ${cliente['nome'] ?? ''}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // Navegar para a tela de edição e aguardar o resultado
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastroCliente(cliente: cliente),
                ),
              );

              if (resultado != null) {
                // Se o cliente foi editado, atualiza os dados
                setState(() {
                  cliente = {...cliente, ...resultado};
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Permite rolagem se o conteúdo for grande
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibe todas as informações do cliente
            _construirInformacao('Nome', cliente['nome'] ?? ''),
            _construirInformacao(
                'Data de Nascimento', cliente['data_nascimento'] ?? ''),
            _construirInformacao('Escolaridade', cliente['escolaridade'] ?? ''),
            _construirInformacao('Profissão', cliente['profissao'] ?? ''),
            _construirInformacao('Estado Civil', cliente['estado_civil'] ?? ''),
            _construirInformacao('Já realizou algum tratamento estético?',
                _formatarBool(cliente['tratamento_estetico'])),
            _construirInformacao('Descrição do Tratamento Estético',
                cliente['tratamento_estetico_descricao'] ?? ''),
            _construirInformacao(
                'Tem filhos?', _formatarBool(cliente['tem_filhos'])),
            _construirInformacao(
                'Está amamentando?', _formatarBool(cliente['amamentando'])),
            _construirInformacao(
                'Como funciona seu intestino?', cliente['intestino'] ?? ''),
            _construirInformacao('Ingere água?', cliente['ingere_agua'] ?? ''),
            _construirInformacao(
                'Hábitos alimentares?', cliente['habitos_alimentares'] ?? ''),
            _construirInformacao('Possui intolerância alimentar?',
                _formatarBool(cliente['intolerancia_alimentar'])),
            _construirInformacao('Descrição da Intolerância Alimentar',
                cliente['intolerancia_alimentar_descricao'] ?? ''),
            _construirInformacao('Ingere bebida alcoólica?',
                _formatarBool(cliente['ingere_bebida_alcoolica'])),
            _construirInformacao('Fuma?', _formatarBool(cliente['fuma'])),
            _construirInformacao('Como é o seu sono?', cliente['sono'] ?? ''),
            _construirInformacao('Pratica atividade física?',
                _formatarBool(cliente['atividade_fisica'])),
            _construirInformacao('Usa cosméticos? Descrição',
                cliente['usa_cosmeticos_descricao'] ?? ''),
            _construirInformacao('Alergias ou irritações? Descrição',
                cliente['alergias_irritacoes_descricao'] ?? ''),
            _construirInformacao('Tem patologias? Descrição',
                cliente['tem_patologias_descricao'] ?? ''),
            _construirInformacao('Tem distúrbio hormonal? Descrição',
                cliente['tem_disturbio_hormonal_descricao'] ?? ''),
            _construirInformacao('Uso de medicamentos? Descrição',
                cliente['uso_medicamento_descricao'] ?? ''),
            _construirInformacao('Deficiência de vitaminas? Descrição',
                cliente['deficiencia_vitaminas_descricao'] ?? ''),
            _construirInformacao(
                'Avaliação da pele', cliente['avaliacao_pele'] ?? ''),
            _construirInformacao('Tratamento', cliente['tratamento'] ?? ''),
            _construirInformacao('Produtos para usar em casa',
                cliente['produtos_para_casa'] ?? ''),
            const SizedBox(height: 20),
            // Botões para exportar os dados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _exportarParaPDF,
                  child: const Text('Exportar para PDF'),
                ),
                ElevatedButton(
                  onPressed: _exportarParaCSV,
                  child: const Text('Exportar para CSV'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget para exibir uma linha de informação
  Widget _construirInformacao(String campo, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  // Função auxiliar para formatar valores booleanos
  String _formatarBool(bool? valor) {
    if (valor == null) return '';
    return valor ? 'Sim' : 'Não';
  }

  // Função para exportar os dados para PDF
  Future<void> _exportarParaPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Informações do Cliente',
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              _buildPdfText('Nome', cliente['nome'] ?? ''),
              _buildPdfText(
                  'Data de Nascimento', cliente['data_nascimento'] ?? ''),
              _buildPdfText('Escolaridade', cliente['escolaridade'] ?? ''),
              _buildPdfText('Profissão', cliente['profissao'] ?? ''),
              _buildPdfText('Estado Civil', cliente['estado_civil'] ?? ''),
              _buildPdfText('Já realizou algum tratamento estético?',
                  _formatarBool(cliente['tratamento_estetico'])),
              _buildPdfText('Descrição do Tratamento Estético',
                  cliente['tratamento_estetico_descricao'] ?? ''),
              _buildPdfText(
                  'Tem filhos?', _formatarBool(cliente['tem_filhos'])),
              _buildPdfText(
                  'Está amamentando?', _formatarBool(cliente['amamentando'])),
              _buildPdfText(
                  'Como funciona seu intestino?', cliente['intestino'] ?? ''),
              _buildPdfText('Ingere água?', cliente['ingere_agua'] ?? ''),
              _buildPdfText(
                  'Hábitos alimentares?', cliente['habitos_alimentares'] ?? ''),
              _buildPdfText('Possui intolerância alimentar?',
                  _formatarBool(cliente['intolerancia_alimentar'])),
              _buildPdfText('Descrição da Intolerância Alimentar',
                  cliente['intolerancia_alimentar_descricao'] ?? ''),
              _buildPdfText('Ingere bebida alcoólica?',
                  _formatarBool(cliente['ingere_bebida_alcoolica'])),
              _buildPdfText('Fuma?', _formatarBool(cliente['fuma'])),
              _buildPdfText('Como é o seu sono?', cliente['sono'] ?? ''),
              _buildPdfText('Pratica atividade física?',
                  _formatarBool(cliente['atividade_fisica'])),
              _buildPdfText('Usa cosméticos? Descrição',
                  cliente['usa_cosmeticos_descricao'] ?? ''),
              _buildPdfText('Alergias ou irritações? Descrição',
                  cliente['alergias_irritacoes_descricao'] ?? ''),
              _buildPdfText('Tem patologias? Descrição',
                  cliente['tem_patologias_descricao'] ?? ''),
              _buildPdfText('Tem distúrbio hormonal? Descrição',
                  cliente['tem_disturbio_hormonal_descricao'] ?? ''),
              _buildPdfText('Uso de medicamentos? Descrição',
                  cliente['uso_medicamento_descricao'] ?? ''),
              _buildPdfText('Deficiência de vitaminas? Descrição',
                  cliente['deficiencia_vitaminas_descricao'] ?? ''),
              _buildPdfText(
                  'Avaliação da pele', cliente['avaliacao_pele'] ?? ''),
              _buildPdfText('Tratamento', cliente['tratamento'] ?? ''),
              _buildPdfText('Produtos para usar em casa',
                  cliente['produtos_para_casa'] ?? ''),
            ],
          );
        },
      ),
    );

    // Imprime o PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // Função auxiliar para construir texto no PDF
  pw.Widget _buildPdfText(String campo, String valor) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4.0),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('$campo: ',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Expanded(
            child: pw.Text(valor),
          ),
        ],
      ),
    );
  }

  // Função para exportar os dados para CSV
  Future<void> _exportarParaCSV() async {
    List<List<dynamic>> rows = [];

    // Adicione os campos que deseja exportar
    rows.add(['Campo', 'Valor']);
    rows.add(['Nome', cliente['nome'] ?? '']);
    rows.add(['Data de Nascimento', cliente['data_nascimento'] ?? '']);
    rows.add(['Escolaridade', cliente['escolaridade'] ?? '']);
    rows.add(['Profissão', cliente['profissao'] ?? '']);
    rows.add(['Estado Civil', cliente['estado_civil'] ?? '']);
    rows.add([
      'Já realizou algum tratamento estético?',
      _formatarBool(cliente['tratamento_estetico'])
    ]);
    rows.add([
      'Descrição do Tratamento Estético',
      cliente['tratamento_estetico_descricao'] ?? ''
    ]);
    rows.add(['Tem filhos?', _formatarBool(cliente['tem_filhos'])]);
    rows.add(['Está amamentando?', _formatarBool(cliente['amamentando'])]);
    rows.add(['Como funciona seu intestino?', cliente['intestino'] ?? '']);
    rows.add(['Ingere água?', cliente['ingere_agua'] ?? '']);
    rows.add(['Hábitos alimentares?', cliente['habitos_alimentares'] ?? '']);
    rows.add([
      'Possui intolerância alimentar?',
      _formatarBool(cliente['intolerancia_alimentar'])
    ]);
    rows.add([
      'Descrição da Intolerância Alimentar',
      cliente['intolerancia_alimentar_descricao'] ?? ''
    ]);
    rows.add([
      'Ingere bebida alcoólica?',
      _formatarBool(cliente['ingere_bebida_alcoolica'])
    ]);
    rows.add(['Fuma?', _formatarBool(cliente['fuma'])]);
    rows.add(['Como é o seu sono?', cliente['sono'] ?? '']);
    rows.add([
      'Pratica atividade física?',
      _formatarBool(cliente['atividade_fisica'])
    ]);
    rows.add([
      'Usa cosméticos? Descrição',
      cliente['usa_cosmeticos_descricao'] ?? ''
    ]);
    rows.add([
      'Alergias ou irritações? Descrição',
      cliente['alergias_irritacoes_descricao'] ?? ''
    ]);
    rows.add([
      'Tem patologias? Descrição',
      cliente['tem_patologias_descricao'] ?? ''
    ]);
    rows.add([
      'Tem distúrbio hormonal? Descrição',
      cliente['tem_disturbio_hormonal_descricao'] ?? ''
    ]);
    rows.add([
      'Uso de medicamentos? Descrição',
      cliente['uso_medicamento_descricao'] ?? ''
    ]);
    rows.add([
      'Deficiência de vitaminas? Descrição',
      cliente['deficiencia_vitaminas_descricao'] ?? ''
    ]);
    rows.add(['Avaliação da pele', cliente['avaliacao_pele'] ?? '']);
    rows.add(['Tratamento', cliente['tratamento'] ?? '']);
    rows.add(
        ['Produtos para usar em casa', cliente['produtos_para_casa'] ?? '']);

    String csvData = const ListToCsvConverter().convert(rows);

    try {
      final directory = await getExternalStorageDirectory();
      final path = "${directory!.path}/cliente_${cliente['id']}.csv";
      final file = File(path);
      await file.writeAsString(csvData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Arquivo CSV salvo em: $path')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar arquivo CSV: $e')),
        );
      }
    }
  }
}
