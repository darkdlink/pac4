import 'package:flutter/material.dart';
import 'package:beautycare_app/telas/tela_login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // inicializar o Supabase antes do runApp

  // Inicializar o Supabase
  await Supabase.initialize(
    url: 'https://dslsvbiyuvezcbzrfrza.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRzbHN2Yml5dXZlemNienJmcnphIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMwMDQ1NDYsImV4cCI6MjA0ODU4MDU0Nn0.CySfcFVHNNTcxXpvpDCtGKiS4QiGq8afXWHoqPv8bI8',
    debug: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeautyCare App',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Define a cor principal
        fontFamily: 'Roboto', // fonte
      ),
      home: const TelaLogin(), // tela inicial
    );
  }
}
