import 'package:flutter/material.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/client_list_screen.dart';
import 'package:app/screens/client_details_screen.dart';
import 'package:app/screens/client_form_screen.dart';
import 'package:app/screens/client_edit_screen.dart';
import 'package:app/screens/settings_screen.dart';
import 'package:app/screens/about_screen.dart';
import 'package:app/models/client.dart';



void main() {


  runApp(const MyApp());




}

class MyApp extends StatelessWidget {




   const MyApp({super.key});


  @override



  Widget build(BuildContext context) {



return MaterialApp(


   debugShowCheckedModeBanner: false,

      title: 'Aesthetic App',
   theme: ThemeData(
    primarySwatch: Colors.blue,

     ),




  home: const SplashScreen(),



 routes: {

        '/login': (context) => const LoginPage(),


     '/clientList': (context) => const ClientListScreen(),




        '/clientForm': (context) => ClientFormScreen(),




'/clientDetails': (context) => const ClientDetailsScreen(client:null,), // Passar um cliente




        '/clientEdit': (context) => const ClientEditScreen(client:null,),// Passar um cliente


'/settings': (context) => const SettingsScreen(),



       '/about': (context) => const AboutScreen(),





 },
 );


   }





}