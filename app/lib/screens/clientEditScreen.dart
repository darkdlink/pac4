import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:aesthetic_app/models/client.dart';
import 'package:aesthetic_app/models/anamnesis_form.dart';
import 'package:aesthetic_app/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientEditScreen extends StatefulWidget {
  final Client client;
  const ClientEditScreen({Key? key, required this.client}) : super(key: key);

  @override
  State<ClientEditScreen> createState() => _ClientEditScreenState();
}

class _ClientEditScreenState extends State<ClientEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _birthDateController;

  // Formulário de Anamnese
  late AnamnesisForm _anamnesisForm;

  final FirebaseService _firebaseService = FirebaseService();
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("dd/MM/yyyy");
  bool _isLoading = false;



   @override
  void initState() {

    super.initState();




     _nameController = TextEditingController(text: widget.client.name);



    _birthDateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(widget.client.birthDate),
    );


_anamnesisForm = widget.client.anamnesis;




  }






@override




void dispose() {




_nameController.dispose();


     _birthDateController.dispose();




 super.dispose();



   }


   Future<void> _updateClient() async {
    if (_formKey.currentState!.validate()) {


        setState(() {




        _isLoading = true;



     });




  try{

           // Atualiza os dados do cliente com os valores dos controladores
        Client updatedClient = Client(




       id: widget.client.id,


name: _nameController.text,

  birthDate: DateTime.parse(_birthDateController.text.split('/').reversed.join('-')),


        anamnesis: _anamnesisForm

     );




        await _firebaseService.updateClient(updatedClient); //chama o método de ClientService para atualizar

       if (!mounted) return; //verifica se não foi desmontado




          Navigator.pop(context); // Voltar para a tela anterior


// ignore: use_build_context_synchronously


      ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(content: Text("Cliente atualizado com sucesso!")));
     }




      on FirebaseException catch (e) {


   if (!mounted) return;



        setState(() {



_isLoading = false;




});

debugPrint(e.message ?? "Ocorreu um erro ao atualizar o cliente.");



ScaffoldMessenger.of(context).showSnackBar(



 const SnackBar(content: Text("Ocorreu um erro ao atualizar as informações do cliente. Por favor, verifique sua conexão ou se todos os campos estão preenchidos corretamente.")));




}




 }


   }





@override




 Widget build(BuildContext context) {


   return Scaffold(


    appBar: AppBar(title: const Text("Editar Cliente")),


       body: Padding(
 padding: const EdgeInsets.all(16.0),

            child: Form(



 key: _formKey,



    child: SingleChildScrollView( // Permite rolagem se o conteúdo for longo demais
child: Column(
 crossAxisAlignment: CrossAxisAlignment.stretch,



 children: [



                     TextFormField(
  controller: _nameController,


                     decoration: const InputDecoration(labelText: 'Nome'),




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



                  decoration: const InputDecoration(labelText: 'Data de Nascimento'),




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




 SwitchListTile(


        value: _anamnesisForm.previousAestheticTreatment,




  onChanged: (value) => setState(() {



   _anamnesisForm.previousAestheticTreatment = value;

 }),




    title: const Text("Já realizou algum tratamento estético?"),



     ),




           SwitchListTile(value: _anamnesisForm.hasChildren,



              onChanged: (value) => setState(() {



         _anamnesisForm.hasChildren = value;

        }),

            title: const Text("Tem Filhos?")),





// ... adicione todos os outros campos do AnamnesisForm com os valores corretos




             ElevatedButton(



        onPressed: _isLoading ? null : _updateClient,



   child: _isLoading




                         ? const CircularProgressIndicator()


// ignore: unnecessary_null_comparison



: const Text('Salvar Alterações')),




 ],


           ),





      ),
 ),




    ),



);



  }





 }