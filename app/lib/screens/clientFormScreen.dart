import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:aesthetic_app/models/client.dart';
import 'package:aesthetic_app/models/anamnesis_form.dart';
import 'package:aesthetic_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';



class ClientFormScreen extends StatefulWidget {



   final Client? client;
    const ClientFormScreen({Key? key, this.client}) : super(key: key);



    @override


    State<ClientFormScreen> createState() => _ClientFormState();

 }



 class _ClientFormState extends State<ClientFormScreen> {



 // Controladores para os campos do formulário



 late TextEditingController _nameController;

late TextEditingController _birthDateController;




    late AnamnesisForm _anamnesisForm;






   final FirebaseService _firebaseService = FirebaseService();



    final _formKey = GlobalKey<FormState>();



    final format = DateFormat("dd/MM/yyyy");
   bool _isLoading = false;




 @override


   void initState() {
     super.initState();

 // Inicializa os controladores e o formulário de anamnese
      _nameController = TextEditingController(text: widget.client?.name);
      _birthDateController = TextEditingController(

           text: widget.client?.birthDate != null


                ? DateFormat('dd/MM/yyyy').format(widget.client!.birthDate)


             : null,



 );




   _anamnesisForm = widget.client?.anamnesis ?? AnamnesisForm(); // Inicializa com os dados do cliente ou um novo formulário


 }





@override


void dispose() {



    _nameController.dispose();



    _birthDateController.dispose();




super.dispose();



 }

 // Método para salvar ou atualizar o cliente




  Future<void> _saveClient() async {




if (_formKey.currentState!.validate()) {



   setState(() {




          _isLoading = true;



        });

  try {




       Client client = Client(
      id: widget.client?.id ?? const Uuid().v4(),//gera id se não tiver


   name: _nameController.text,

          birthDate: DateTime.parse(_birthDateController.text.split("/").reversed.join("-")),




    anamnesis: _anamnesisForm



 );


 //Chamada ao serviço do firebase




        if (widget.client != null) {




         await _firebaseService.updateClient(client); // Atualiza o cliente



       }




         else{


              await _firebaseService.addClient(client);




 }


 Navigator.of(context).pop();//volta para a tela anterior

    if (mounted) { // Verifica se o widget ainda está montado
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cliente salvo com sucesso!")));


 }



     } on FirebaseException catch (e) {


 if (mounted) // verificar se está montado




  setState(() {


       _isLoading = false;

  });
 // Tratar o erro e exibir mensagem para o usuário
// ignore: use_build_context_synchronously
ScaffoldMessenger.of(context).showSnackBar(


         SnackBar(content: Text('Erro ao salvar cliente: ${e.message}')));





   }



  }



 }







 Widget build(BuildContext context) {




 return Scaffold(
 appBar: AppBar(



   title: Text(widget.client != null ? "Editar Cliente" : "Criar Cliente")


       ),


        body: Padding(


  padding: const EdgeInsets.all(16.0),



      child: Form(
      key: _formKey, // Chave para validação do formulário




   child: SingleChildScrollView(
               child: Column(


     crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos para ocupar a largura disponível


    children: [




   TextFormField(
 controller: _nameController,
decoration: const InputDecoration(labelText: "Nome Completo"),



                     validator: (value) {

                         if (value == null || value.isEmpty) {



                         return 'Por favor, digite o nome';


                       }




     return null;

    },





),

DateTimeField(
    format: format,




              controller: _birthDateController,




 decoration: const InputDecoration(labelText: "Data de Nascimento"),
                validator: (value) {



                     if (value == null) {




      return 'Por favor, selecione a data de nascimento';


    }
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
}




                     else{




                         return currentValue;




}



     },
            ),


// ... (Adicione os outros campos do formulário aqui, incluindo os da anamnese)



      ElevatedButton(




                 onPressed: _isLoading ? null : _saveClient,
       child: _isLoading

                       ? const CircularProgressIndicator()
 // ignore: unnecessary_null_comparison



 : const Text('Salvar')

),


  ],





              ),
),






          ),


  ),




   );


 }



 }