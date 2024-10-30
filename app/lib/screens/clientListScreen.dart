import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aesthetic_app/models/client.dart';
import 'package:aesthetic_app/screens/client_details_screen.dart';
import 'package:aesthetic_app/screens/client_form_screen.dart';
import 'package:intl/intl.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('clients');
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }


 @override

  void dispose() {




  _searchController.removeListener(_onSearchChanged);



_searchController.dispose();

   super.dispose();



  }





 void _onSearchChanged() {
    setState(() {

       _searchTerm = _searchController.text;


     });


   }






@override

 Widget build(BuildContext context) {


  return Scaffold(

    appBar: AppBar(

          title: const Text('Clientes'),



       actions: [



       IconButton(




             onPressed: () {


               Navigator.pushNamed(context, '/clientForm'); // rota

              },


               icon: const Icon(Icons.add))



    ],

 ),


    body: Column(children: [
           Padding(

padding: const EdgeInsets.all(8.0),
child: TextField(


        controller: _searchController,


            decoration: InputDecoration(


       hintText: 'Pesquisar...',


            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
           onChanged: (text) {



            _onSearchChanged();


           },





 ),


   ),



  Expanded(


            child: StreamBuilder<QuerySnapshot>(




  stream: _clientsCollection.snapshots(),

              builder: (context, snapshot) {
                 if (snapshot.hasError) {




          print("Ocorreu um erro ${snapshot.error}");




            return const Center(child: Text("Erro ao carregar dados."));

  }




             if (!snapshot.hasData) {




             return const Center(child: CircularProgressIndicator());
   }

var filteredClients = _searchTerm.isEmpty
                    ? snapshot.data!.docs


                     : snapshot.data!.docs.where((doc) {



   String name = (doc.data() as Map<String, dynamic>)['name']?.toString() ?? '';



                    return name.toLowerCase().contains(_searchTerm.toLowerCase());

                      }).toList();
                    return ListView.builder(
        itemCount: filteredClients.length,


                  itemBuilder: (context, index) {
//converte de map para objeto client




                       final clientData =




                   filteredClients[index].data() as Map<String, dynamic>;




                     final clientId = filteredClients[index].id;




  final client = Client.fromMap(clientData, clientId);



      return ListTile(


                          title: Text(client.name),




         subtitle: Text(DateFormat('dd/MM/yyyy').format(client.birthDate)),



         onTap: () {
 Navigator.push(context, MaterialPageRoute(builder: (context) => ClientDetailsScreen(client:client)));




},

                      );


                    },




                   );
   }





    ),

 )


 ],


     ),




  );


}


}