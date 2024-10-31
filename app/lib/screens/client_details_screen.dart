import 'package:flutter/material.dart';
import 'package:intl/DateFormat.dart';
import 'package:app/models/client.dart';
import 'package:app/screens/client_edit_screen.dart';


class ClientDetailsScreen extends StatelessWidget {
  final Client client;

  const ClientDetailsScreen({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(client.name)),


 body: SingleChildScrollView(

 padding: const EdgeInsets.all(16.0),



        child: Column(


crossAxisAlignment: CrossAxisAlignment.start,
children: [



 _buildSectionTitle("Dados Pessoais"),



_buildDataField("Nome:", client.name),



           _buildDataField("Data de Nascimento:",
DateFormat('dd/MM/yyyy').format(client.birthDate)),
// ... outros campos




            _buildSectionTitle("Ficha de Anamnese"),
_buildDataField("Tratamento estético prévio:", client.anamnesis.previousAestheticTreatment ? "Sim" : "Não"),
_buildDataField("Tem Filhos?:", client.anamnesis.hasChildren ? "Sim" : "Não"),


  _buildDataField("Está amamentando?", client.anamnesis.isBreastfeeding ? "Sim" : "Não"),


_buildDataField("Como funciona seu intestino:", client.anamnesis.bowelFunction),




 _buildDataField("Ingere água?:", client.anamnesis.waterIntake),

_buildDataField("Hábitos alimentares:", client.anamnesis.eatingHabits),

_buildDataField("Intolerância alimentar?:", client.anamnesis.foodIntolerance ? "Sim" : "Não"),


   _buildDataField("Ingere bebida alcoólica?:", client.anamnesis.alcoholicBeverageIntake ? "Sim" : "Não"),
       _buildDataField("Fuma?:", client.anamnesis.smoking ? "Sim" : "Não"),
           _buildDataField("Qualidade do sono:", client.anamnesis.sleepQuality),
     _buildDataField("Pratica atividade física?:", client.anamnesis.physicalActivity ? "Sim" : "Não"),


      _buildDataField("Usa cosméticos?:", client.anamnesis.usesCosmetics ? "Sim" : "Não"),

           _buildDataField("Alergias ou irritações?:", client.anamnesis.allergiesOrIrritations ? "Sim" : "Não"),
    _buildDataField("Queloide?:", client.anamnesis.keloid ? "Sim" : "Não"),




           _buildDataField("Manchas na pele com facilidade?:", client.anamnesis.easySkinStaining ? "Sim" : "Não"),
        _buildDataField("Patologias?:", client.anamnesis.pathologies ? "Sim" : "Não"),


             _buildDataField("Distúrbio hormonal?:", client.anamnesis.hormonalDisorder ? "Sim" : "Não"),



_buildDataField("Usa anticoncepcional?:", client.anamnesis.usesContraceptive ? "Sim" : "Não"),




  _buildDataField("Usa antidepressivo?:", client.anamnesis.usesAntidepressant ? "Sim" : "Não"),




        _buildDataField("Medicamentos:", client.anamnesis.medication),

  _buildDataField("Deficiência de vitaminas?:", client.anamnesis.vitaminDeficiency ? "Sim" : "Não"),
_buildDataField("Unhas e cabelos fracos?:", client.anamnesis.weakNailsAndHair ? "Sim" : "Não"),
           _buildDataField("Avaliação da pele:", client.anamnesis.skinEvaluation),


 _buildDataField("Tratamento:", client.anamnesis.treatment),




    _buildDataField("Produtos para uso em casa:", client.anamnesis.homeProducts),


ElevatedButton(



 onPressed: () {


       Navigator.pushNamed(context, '/clientEdit', arguments: client);





        },
            child: const Text('Editar'),



       ),


       ],

),

 ),



  );



}

Widget _buildSectionTitle(String title) {



 return Padding(



         padding: const EdgeInsets.symmetric(vertical: 12.0),

         child: Text(


             title,



style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),




       ),




 );




}



 Widget _buildDataField(String label, String value) {




  return Padding(


padding: const EdgeInsets.symmetric(vertical: 4.0),

       child: RichText(




         text: TextSpan(


                text: "$label ",




         style: const TextStyle(fontWeight: FontWeight.bold),



                children: [


TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.normal))




        ],



       ),




),




   );





  }

}