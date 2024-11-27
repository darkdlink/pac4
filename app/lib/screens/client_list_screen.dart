import 'package:flutter/material.dart';
import 'package:app/models/client.dart';
import 'package:app/screens/client_details_screen.dart';
import 'package:intl/intl.dart';


class ClientListScreen extends StatefulWidget {

const ClientListScreen({Key? key}) : super(key: key);



 @override




 State<ClientListScreen> createState() => _ClientListScreenState();


}


class _ClientListScreenState extends State<ClientListScreen> {





late Future<List<Client>> _clientListFuture;//inicializar ao criar a tela
   final TextEditingController _searchController = TextEditingController();
   String _searchTerm = '';




   @override



 void initState() {

 super.initState();

<<<<<<< HEAD
    //_clientService = LocalClientService();
    //_clientsFuture = _clientService.getAllClients();
=======

>>>>>>> parent of 85d8f7e (Tela)


    _searchController.addListener(_onSearchChanged);


<<<<<<< HEAD
  //_clientListFuture = _clientService.getAllClients(); // Buscar a lista de clientes inicial
=======
 // _clientListFuture = _clientService.getAllClients(); // Buscar a lista de clientes inicial
>>>>>>> parent of 85d8f7e (Tela)



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



  Navigator.pushNamed(context, '/clientForm');

 },


   icon: const Icon(Icons.add))



 ],

      ),



 body: Column(



       children: [




           Padding(




           padding: const EdgeInsets.all(8.0),


             child: TextField(


          controller: _searchController,
    decoration: InputDecoration(

                hintText: 'Pesquisar...',

        prefixIcon: const Icon(Icons.search),

 border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),


 onChanged: (text){
                     _onSearchChanged();//chama com onChanged

                  },




              ),




             ),

 Expanded(

  child: FutureBuilder<List<Client>>(
 future: _clientListFuture,
                      builder: (context, snapshot) {


//Tratar erros/loading

                   if (snapshot.connectionState == ConnectionState.waiting) {


                   return const Center(child: CircularProgressIndicator());


                }



                else if (snapshot.hasError){


    return const Center(child: Text("Error ao carregar clients"));
     }



    else if (!snapshot.hasData || snapshot.data!.isEmpty) {

        return const Center(child: Text('Nenhum cliente encontrado.'));




                     }



                 // Filtrar a lista com base no termo de busca


  final filteredClients = _searchTerm.isEmpty ? snapshot.data! : snapshot.data!.where((client) => client.name.toLowerCase().contains(_searchTerm.toLowerCase())).toList();



                     return ListView.builder(




           itemCount: filteredClients.length,



    itemBuilder: (context, index) {




                   final client = filteredClients[index];




                    return ListTile(



                     title: Text(client.name),




             subtitle: Text(DateFormat('dd/MM/yyyy').format(client.birthDate)),
      onTap: () {




 Navigator.pushNamed(

                           context,




                            '/clientDetails', arguments: client);



                    },
                       );


                      },


                       );





                    }





                   ),

           ),




    ],




     ),





 );




  }

   @override

 void dispose() {


  _searchController.removeListener(_onSearchChanged);
  _searchController.dispose();

  super.dispose();




 }

}