<<<<<<< HEAD
import 'package:app/models/client.dart';
import 'package:flutter/material.dart';
import 'client_list_screen.dart';
=======
import 'package:flutter/material.dart';
>>>>>>> parent of 85d8f7e (Tela)
import 'package:app/screens/recover_password_screen.dart';

class LoginPage extends StatefulWidget {


 const LoginPage({Key? key}) : super(key: key);



  @override
 // ignore: library_private_types_in_public_api

  _LoginPageState createState() => _LoginPageState();
 }

class _LoginPageState extends State<LoginPage> {



 final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();


 bool _isLoading = false;


   bool _obscurePassword = true;
@override




void initState() {




    super.initState();


print("Login Screen carregada"); // Adicione um print para verificar quando a tela é carregada


}
@override




void dispose(){




   _emailController.dispose();



    _passwordController.dispose();




    super.dispose();




}

<<<<<<< HEAD
=======
 // Método _login sem a lógica do Firebase (apenas navega para a lista)
>>>>>>> parent of 85d8f7e (Tela)




Future<void> _login() async {



if (_formKey.currentState!.validate()) {




    // Navega para a tela da lista de clientes


<<<<<<< HEAD
       Navigator.push(context, MaterialPageRoute(builder: (context) => const ClientListScreen()));

//      Navigator.pushReplacementNamed(context, '/client_list_screen');
=======

      Navigator.pushReplacementNamed(context, '/clientList');
>>>>>>> parent of 85d8f7e (Tela)

   }




 }

@override



Widget build(BuildContext context) {




    return Scaffold(


    appBar: AppBar(title: const Text('Login')),


  body: Padding(



padding: const EdgeInsets.all(16.0),
child: Form(



             key: _formKey,


  child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                  children: [



                   TextFormField(

   controller: _emailController,


                   decoration: const InputDecoration(labelText: 'Email'),



        validator: (value) {



                       if (value == null || value.isEmpty) {


      return 'Por favor, digite seu email';
                         }

return null;


                      },


       keyboardType: TextInputType.emailAddress,




                 ),



 const SizedBox(height: 16),


TextFormField(
     controller: _passwordController,

decoration: InputDecoration(



       labelText: 'Senha',

suffixIcon: IconButton(



icon: Icon(




    _obscurePassword



                                ? Icons.visibility




                             : Icons.visibility_off




                             ),
                            onPressed: () {



  setState(() {



   _obscurePassword = !_obscurePassword;



 });

  },


                         )
),




                  obscureText: _obscurePassword,


                       validator: (value) {
                       if (value == null || value.isEmpty) {

       return 'Por favor, digite sua senha';

 }
        return null;



    },
     keyboardType: TextInputType.visiblePassword,




  ),
           const SizedBox(height: 24),




     ElevatedButton(


                  onPressed: _isLoading ? null : _login,





                  child: _isLoading

   ? const CircularProgressIndicator()




                : const Text('Entrar')




                 ),



               TextButton(



   onPressed: () {




 Navigator.push(context, MaterialPageRoute(builder: (context) => const RecoverPasswordScreen()));





   },

                child: const Text('Esqueci minha senha'),




 ),





                 ],

),






 ),




),






);
 }
 }