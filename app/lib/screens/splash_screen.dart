import 'dart:async';
import 'package:flutter/material.dart';

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


      Navigator.pushReplacementNamed(context, '/login');

    });



  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset('assets/logo.png')), // Substitua pelo caminho da sua logo

    );


   }




 }