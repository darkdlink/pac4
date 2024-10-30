import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aesthetic_app/screens/login_screen.dart';
import 'package:aesthetic_app/screens/client_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    User? user = FirebaseAuth.instance.currentUser; // verifica o usuario atual no Firebase

      if (user != null) {




      Navigator.pushReplacementNamed(context, '/clientList');


       }




     else {



      Navigator.pushReplacementNamed(context, '/login');


     }



  }

  @override
  Widget build(BuildContext context) {


     return Scaffold(
        body: Center(
          child: Image.asset('assets/logo.png'), // Substitua pelo caminho da logo

           ),


   );
   }


 }