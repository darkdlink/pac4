<<<<<<< HEAD
//import 'package:app/models/client.dart';
=======
import 'package:app/models/client.dart';
>>>>>>> parent of 85d8f7e (Tela)
import 'package:app/models/anamnesis_form.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';



class LocalClientService {




  late Database _database;



  final String _tableName = 'clients';




Future<Database> initializeDB() async {




 String path = await getDatabasesPath();

 return openDatabase(


       join(path, 'aesthetic_app.db'),


        onCreate: (db, version) async {




          await db.execute('''




  CREATE TABLE $_tableName(
   id TEXT PRIMARY KEY,

  name TEXT,



           birthDate TEXT,


             anamnesis TEXT



           )
  ''');
 },




        version: 1,




      );


   }

// Buscar todos os clientes



Future<List<Client>> getAllClients() async {

  await initializeDB();//inicia a db


  final List<Map<String, dynamic>> maps = await _database.query(_tableName);
   return List.generate(maps.length, (i) {





    // Decodificar o JSON da anamnese



        Map<String, dynamic> anamnesisMap = jsonDecode(maps[i]['anamnesis']);




        AnamnesisForm anamnesis = AnamnesisForm.fromMap(anamnesisMap);
 //Note que no fromMap vc deve ter a mesma estrutura do seu toMap e da sua classe de modelo para evitar erros




   return Client.fromMap(maps[i], maps[i]['id'], anamnesis);
    //passar anamnesis para o fromMap, a partir do modelo obtido do json.




  });



  }




  Future<void> createClient(Client client) async {
  await initializeDB();


// Converter a data de nascimento para string
 String birthDateString = client.birthDate.toIso8601String();

// Converter a ficha de anamnese para um JSON string




String anamnesisJson = jsonEncode(client.anamnesis.toMap()); //use jsonEncode,  e o `toMap` que retorna um Map<String, dynamic>.





 _database.insert(
_tableName,




      {

    'id': client.id,




             'name': client.name,




  'birthDate': birthDateString,



'anamnesis': anamnesisJson,
  },
         conflictAlgorithm: ConflictAlgorithm.replace


       );



      //debugPrint('Cliente criado com o ID: ${client.id}');

 }

Future<void> updateClient(Client updatedClient) async {


      await initializeDB();


      String birthDateString = updatedClient.birthDate.toIso8601String();



 String anamnesisJson = jsonEncode(updatedClient.anamnesis.toMap());
 // Converter a ficha de anamnese para um JSON string



    int rowsAffected = await _database.update(
_tableName,



           {




 'name': updatedClient.name,



              'birthDate': birthDateString,
              'anamnesis': anamnesisJson,




 },


        where: 'id = ?',
 whereArgs: [updatedClient.id],
    );
 //debugPrint('$rowsAffected cliente(s) atualizado(s)');




}
 Future<int> deleteClient(String id) async{

     Database db = await initializeDB();
return await db.delete(_tableName, where: 'id=?', whereArgs: [id]);
 }
 Future close() async => _database.close();



}



//Modifique sua classe client para receber anamnesis por parâmetro

class Client {



    String id;



    String name;



   DateTime birthDate;

AnamnesisForm anamnesis;



  Client(


    {this.id = '',




required this.name,


   required this.birthDate,




     required this.anamnesis




 });






Map<String, dynamic> toMap() {


   return {




  'id':id,



    'name': name,




           'birthDate': birthDate.toIso8601String(),
'anamnesis': anamnesis.toMap(),



    };


 }

factory Client.fromMap(Map<String, dynamic> map, String documentId, AnamnesisForm anamnesis) {

return Client(


         id: documentId,

         name: map['name'] ?? '',
  birthDate: (map['birthDate'] is String && map['birthDate'].isNotEmpty)
  ? DateTime.parse(map['birthDate'] as String)


: DateTime.now(), //corrigido para retornar um DateTime

       anamnesis: anamnesis, // recebe anamnesis do mapeamento feito anteriormente na chamada
      );




    }





}