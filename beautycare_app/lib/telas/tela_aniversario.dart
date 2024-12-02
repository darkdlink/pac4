import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaAniversario extends StatefulWidget {
  const TelaAniversario({Key? key}) : super(key: key);

  @override
  TelaAniversarioState createState() => TelaAniversarioState();
}

class TelaAniversarioState extends State<TelaAniversario> {
  List<Map<String, dynamic>> clientes = [];
  List<Map<String, dynamic>> aniversariantes = [];
  DateTime? dataFiltro;

  @override
  void initState() {
    super.initState();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    try {
      final data = await Supabase.instance.client
          .from('cliente')
          .select('id, nome, data_nascimento');

      setState(() {
        clientes = List<Map<String, dynamic>>.from(data);
        _filtrarAniversariantes();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar clientes: $e')),
        );
      }
    }
  }

  void _filtrarAniversariantes() {
    final hoje = DateTime.now();
    final dataReferencia = dataFiltro ?? hoje;

    setState(() {
      aniversariantes = clientes.where((cliente) {
        final dataNascimentoStr = cliente['data_nascimento'];
        if (dataNascimentoStr == null) return false;

        DateTime? dataNascimento;
        try {
          dataNascimento = DateTime.parse(dataNascimentoStr);
        } catch (e) {
          return false;
        }

        // Ajusta o ano para o ano atual
        final aniversarioEsteAno = DateTime(
          dataReferencia.year,
          dataNascimento.month,
          dataNascimento.day,
        );

        // Calcula a diferença em dias entre a data de referência e o aniversário
        final diferencaDias =
            aniversarioEsteAno.difference(dataReferencia).inDays;

        // Retorna true se o aniversário for na data de referência ou nos próximos 2 dias
        return diferencaDias >= 0 && diferencaDias <= 2;
      }).toList();

      // Ordena os aniversariantes pela data de aniversário
      aniversariantes.sort((a, b) {
        final dataA = DateTime.parse(a['data_nascimento']);
        final dataB = DateTime.parse(b['data_nascimento']);
        return dataA.compareTo(dataB);
      });
    });
  }

  Future<void> _selecionarDataFiltro() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataFiltro ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != dataFiltro) {
      setState(() {
        dataFiltro = picked;
        _filtrarAniversariantes();
      });
    }
  }

  String _formatarData(DateTime data) {
    return DateFormat('dd/MM').format(data);
  }

  @override
  Widget build(BuildContext context) {
    final dataReferencia = dataFiltro ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aniversariantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _selecionarDataFiltro,
            tooltip: 'Selecionar data de referência',
          ),
        ],
      ),
      body: Column(
        children: [
          if (dataFiltro != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Aniversariantes a partir de ${DateFormat('dd/MM/yyyy').format(dataFiltro!)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: aniversariantes.isEmpty
                ? const Center(
                    child: Text('Nenhum aniversariante encontrado.'),
                  )
                : ListView.builder(
                    itemCount: aniversariantes.length,
                    itemBuilder: (context, index) {
                      final cliente = aniversariantes[index];
                      final dataNascimentoStr = cliente['data_nascimento'];
                      DateTime dataNascimento =
                          DateTime.parse(dataNascimentoStr);
                      DateTime proximoAniversario = DateTime(
                        dataReferencia.year,
                        dataNascimento.month,
                        dataNascimento.day,
                      );

                      // Se o aniversário já passou este ano, ajusta para o próximo ano
                      if (proximoAniversario.isBefore(dataReferencia)) {
                        proximoAniversario = DateTime(
                          dataReferencia.year + 1,
                          dataNascimento.month,
                          dataNascimento.day,
                        );
                      }

                      final diferencaDias =
                          proximoAniversario.difference(dataReferencia).inDays;

                      return ListTile(
                        title: Text(cliente['nome'] ?? 'Sem nome'),
                        subtitle: Text(
                            'Aniversário em ${_formatarData(proximoAniversario)}'),
                        trailing: diferencaDias == 0
                            ? const Icon(Icons.cake, color: Colors.pink)
                            : diferencaDias == 1
                                ? const Icon(Icons.cake, color: Colors.orange)
                                : diferencaDias == 2
                                    ? const Icon(Icons.cake,
                                        color: Colors.yellow)
                                    : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
