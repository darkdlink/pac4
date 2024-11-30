import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:csv/csv.dart'; // Correto: importando o pacote csv
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
            
            const SizedBox(height: 20),

            // Botões para exportar os dados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _exportarParaPDF(context);
                  },
                  child: const Text('Exportar para PDF'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _exportarParaCSV(context);
                  },
                  child: const Text('Exportar para CSV'),
                ),
              ],
            ),
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

  // Função para exportar os dados para PDF
  Future<void> _exportarParaPDF(BuildContext context) async {
    final pdf = pw.Document();
    
    // Adicionando uma página no PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Informações do Cliente', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              _buildPdfText('Nome', nome),
              _buildPdfText('Data de Nascimento', dataNascimento),
              _buildPdfText('Escolaridade', escolaridade),
              _buildPdfText('Profissão', profissao),
              _buildPdfText('Estado Civil', estadoCivil),
            ],
          );
        },
      ),
    );

    // Imprimindo o PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  // Função auxiliar para criar os textos no PDF
  pw.Widget _buildPdfText(String campo, String valor) {
    return pw.Row(
      children: [
        pw.Text('$campo: ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(valor),
      ],
    );
  }

  // Função para exportar os dados para CSV
  Future<void> _exportarParaCSV(BuildContext context) async {
    // Dados a serem exportados para CSV
    List<List<String>> rows = [
      ["Campo", "Valor"],
      ["Nome", nome],
      ["Data de Nascimento", dataNascimento],
      ["Escolaridade", escolaridade],
      ["Profissão", profissao],
      ["Estado Civil", estadoCivil],
    ];

    // Converte a lista para CSV com ListToCsvConverter
    String csvData = const ListToCsvConverter().convert(rows);

    // Salva o arquivo CSV no dispositivo
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/cliente.csv";
    final file = File(path);
    await file.writeAsString(csvData);

    // Exibe um snackbar ou algo similar para o usuário
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Arquivo CSV salvo em: $path')),
    );
  }
}
