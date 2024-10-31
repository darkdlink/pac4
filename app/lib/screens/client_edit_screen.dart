import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'app/models/client.dart';
import 'package:app/models/anamnesis_form.dart';


class ClientEditScreen extends StatefulWidget {
 final Client client; // Recebe o cliente como argumento
 const ClientEditScreen({Key? key, required this.client}) : super(key: key);



  @override




State<ClientEditScreen> createState() => _ClientEditScreenState();



 }


class _ClientEditScreenState extends State<ClientEditScreen> {


 //Controladores
    late TextEditingController _nameController;
 late TextEditingController _birthDateController;


  late AnamnesisForm _anamnesisForm;


  final LocalClientService _clientService = LocalClientService();//Seu serviço
   bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();


final format = DateFormat("dd/MM/yyyy");


 @override




 void initState() {

  super.initState();


// Inicializa controladores com os dados do cliente


  _nameController = TextEditingController(text: widget.client.name);




   _birthDateController = TextEditingController(
 text: DateFormat('dd/MM/yyyy').format(widget.client.birthDate),


   );




   _anamnesisForm = widget.client.anamnesis;
 }




  @override


  void dispose() {

// Descarta controladores para evitar memory leaks



_nameController.dispose();




_birthDateController.dispose();



super.dispose();
 }



 Future<void> _updateClient() async {



    if (_formKey.currentState!.validate()) {


  setState(() {


       _isLoading = true;



  });

try {



     Client updatedClient = Client(
          id: widget.client.id,




     name: _nameController.text,



       birthDate: DateTime.parse(_birthDateController.text.split('/').reversed.join('-')),
 anamnesis: _anamnesisForm




 );


        await _clientService.updateClient(updatedClient);// Atualiza o cliente usando seu serviço local



if (mounted) {





    Navigator.pop(context);  // Voltar para a tela anterior

 ScaffoldMessenger.of(context)



       .showSnackBar(const SnackBar(content: Text('Cliente atualizado com sucesso!')));



    }

     }




     catch (e) {
      debugPrint('Erro ao atualizar o cliente: $e');
         if (mounted) {


             setState(() {



 _isLoading = false;



 });

           ScaffoldMessenger.of(context)



    .showSnackBar(const SnackBar(content: Text('Erro ao atualizar cliente.')));



        }



   }




}

}




@override



Widget build(BuildContext context) {

return Scaffold(


    appBar: AppBar(title: const Text('Editar Cliente')),


body: Padding(

 padding: const EdgeInsets.all(16),


child: Form( //Form para validações



            key: _formKey,



     child: SingleChildScrollView(
          child: Column(



                 crossAxisAlignment: CrossAxisAlignment.stretch,



 children: [

                TextFormField(




     controller: _nameController,



   decoration: const InputDecoration(labelText: "Nome"),




                  validator: (value) {




 if (value == null || value.isEmpty)
     return 'Por favor, insira um nome.';





                        return null;
},
),




DateTimeField(



    format: format,



      controller: _birthDateController,


decoration: const InputDecoration(labelText: "Data de Nascimento"),


validator: (value) {




                  if (value == null)

return 'Por favor, insira a data de nascimento.';




                       return null;


                  },





     onShowPicker: (context, currentValue) async {


       final date = await showDatePicker(
    context: context,




     initialDate: currentValue ?? DateTime.now(),


firstDate: DateTime(1900),





lastDate: DateTime(2100)

     );

        return date;





},


),




 // ... (Os outros campos do formulário, incluindo os da anamnese)





       SwitchListTile(




  value: _anamnesisForm.previousAestheticTreatment,
     onChanged: (value) => setState(() {


_anamnesisForm.previousAestheticTreatment = value;

 }),

title: const Text("Já realizou algum tratamento estético?"),),





        // ... outros campos da anamnese


                 ElevatedButton(
                   onPressed: _isLoading ? null : _updateClient,


                 child: _isLoading
                       ? const CircularProgressIndicator()




                       : const Text("Salvar Alterações"),
),




       ],




  ),



   ),


 ),
),






 );

}


 }