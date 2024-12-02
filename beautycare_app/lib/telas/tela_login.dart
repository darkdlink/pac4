import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Importando o Supabase
import 'package:beautycare_app/telas/tela_menu.dart'; // Importe a tela de menu

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _senhaVisivel = false; // Controle para exibir ou ocultar a senha

  // Função de login
  Future<void> _login() async {
    final email = _usuarioController.text;
    final password = _senhaController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Por favor, insira o e-mail e senha'),
      ));
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Erro: Credenciais inválidas'),
        ));
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TelaMenu()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao autenticar: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDB9B83), // Cor do fundo
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Image.asset('assets/imagens/logo.png'),
              ),
              // Formulário de login
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo de Usuário
                      TextFormField(
                        controller: _usuarioController,
                        decoration: InputDecoration(
                          hintText: 'Usuário (Email)',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o e-mail';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0), // Espaço entre os campos
                      // Campo de Senha
                      TextFormField(
                        controller: _senhaController,
                        obscureText:
                            !_senhaVisivel, // Alterna entre mostrar e ocultar
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _senhaVisivel
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _senhaVisivel =
                                    !_senhaVisivel; // Alterna a visibilidade da senah
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a senha';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      // Botão de Login
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF966C5C),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _login();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
