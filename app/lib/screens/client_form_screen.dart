import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:app/models/anamnesis_form.dart';
import 'package:app/service/local_client_services.dart';
import 'package:uuid/uuid.dart';

class ClientFormScreen extends StatefulWidget {
  final Client? client; // Parâmetro opcional para edição

  const ClientFormScreen({Key? key, this.client}) : super(key: key);

  @override
  State<ClientFormScreen> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientFormScreen> {
  late TextEditingController _nameController;

  late TextEditingController _birthDateController;

  late AnamnesisForm _anamnesisForm;
  final LocalClientService _clientService = LocalClientService();
  final _formKey = GlobalKey<FormState>();

  final format = DateFormat("dd/MM/yyyy");

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.client?.name);
    _birthDateController = TextEditingController(
      text: widget.client?.birthDate != null
          ? DateFormat('dd/MM/yyyy').format(widget.client!.birthDate)
          : null,
    );
    _anamnesisForm = widget.client?.anamnesis ?? AnamnesisForm();
  }

  @override
  void dispose() {
    _nameController.dispose();

    _birthDateController.dispose();

    super.dispose();
  }

  Future<void> _saveClient() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        //cria novo client.  passar os valores corretos de cada campo

        String newId = const Uuid().v4(); //Gerar um novo UUID

        Client client = Client(
            id: widget.client == null ? newId : widget.client!.id,
            name: _nameController.text,
            birthDate: DateTime.parse(
                _birthDateController.text.split("/").reversed.join("-")),
            anamnesis: _anamnesisForm);
        if (widget.client != null) {
//atualizar
          await _clientService.updateClient(client);
        } else {
          await _clientService.createClient(client);
        }

        // ignore: use_build_context_synchronously

        Navigator.of(context).pop();

        // ignore: use_build_context_synchronously

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cliente salvo com sucesso!')));
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }

        debugPrint('Erro ao salvar cliente: $e');

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao salvar cliente.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.client != null ? "Editar Cliente" : "Criar Cliente")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome Completo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o nome completo.';
                    }

                    return null;
                  },
                ),

                DateTimeField(
                  format: format,
                  controller: _birthDateController,
                  decoration:
                      const InputDecoration(labelText: 'Data de Nascimento'),
                  validator: (value) {
                    if (value == null)
                      return 'Por favor, selecione a data de nascimento.';

                    return null;
                  },
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: currentValue ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    if (date != null) {
                      return date;
                    } else {
                      return currentValue;
                    }
                  },
                ),

                const SizedBox(height: 18),
                const Text(
                  "Consulta Avaliativa Integrativa",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SwitchListTile(
                  value: _anamnesisForm.previousAestheticTreatment,
                  onChanged: (value) => setState(() {
                    _anamnesisForm.previousAestheticTreatment = value;
                  }),
                  title: const Text("Já realizou algum tratamento estético?"),
                ),

                SwitchListTile(
                  value: _anamnesisForm.hasChildren,
                  onChanged: (value) => setState(() {
                    _anamnesisForm.hasChildren = value;
                  }),
                  title: const Text("Tem Filhos?"),
                ),

                SwitchListTile(
                  value: _anamnesisForm.isBreastfeeding,
                  onChanged: (value) => setState(() {
                    _anamnesisForm.isBreastfeeding = value;
                  }),
                  title: const Text("Está amamentando?"),
                ),

                TextFormField(
                  initialValue: _anamnesisForm.bowelFunction,
                  decoration: const InputDecoration(
                      labelText: "Como funciona seu intestino?"),
                  onChanged: (value) {
                    _anamnesisForm.bowelFunction = value;
                  },
                ),

                // Adicione o restante dos campos da sua ficha de anamnese aqui.

                //TextFormField, DropdownButtonFormField ou outro widget que corresponda à sua necessidade para capturar informações ou exibir valores pré-definidos para o formulário.

                ElevatedButton(
                  onPressed: _isLoading ? null : _saveClient,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
