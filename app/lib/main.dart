import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aesthetic_app/screens/login_screen.dart';
import 'package:aesthetic_app/screens/client_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:aesthetic_app/screens/splash_screen.dart';



void main() async {


 WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp(




   options: DefaultFirebaseOptions.currentPlatform,



);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {



  const MyApp({super.key});




 @override




 Widget build(BuildContext context) {



    return MaterialApp(
        debugShowCheckedModeBanner: false,


title: "Aesthetic app",



 theme: ThemeData(




primarySwatch: Colors.blue), 
      home: const SplashScreen(), // Mostra a SplashScreen inicialmente


       routes: { 
        
        // Rotas nomeadas para navegação


          '/login': (context) => const LoginPage(),




          '/clientList': (context) => const ClientListScreen(),
             //


    },




     );

   }

}