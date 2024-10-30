import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aesthetic_app/screens/recover_password_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;


   @override


  void dispose(){
  _emailController.dispose();



   _passwordController.dispose();




    super.dispose();

}



 Future<void> _login() async {




   if (_formKey.currentState!.validate()) {


      setState(() {


     _isLoading = true;



       });



   try {
         UserCredential userCredential = await FirebaseAuth.instance

.signInWithEmailAndPassword(

                 email: _emailController.text,

 password: _passwordController.text

           );

// ignore: use_build_context_synchronously



Navigator.pushReplacementNamed(context, '/clientList');


   } on FirebaseAuthException catch (e) {
         setState(() {

_isLoading = false;



           });

     if (e.code == 'user-not-found') {





// ignore: use_build_context_synchronously




        ScaffoldMessenger.of(context).showSnackBar(


const SnackBar(content: Text('Nenhum usuário encontrado para esse e-mail.')));


         }



     else if (e.code == 'wrong-password') {
             // ignore: use_build_context_synchronously
           ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(content: Text('Senha incorreta.')));

         }


         else {




           // ignore: use_build_context_synchronously

     ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Erro ao fazer login: ${e.message}')));





}




   }


   }



}







@override
 Widget build(BuildContext context) {

 return Scaffold(

  appBar: AppBar(title: const Text("Login"), automaticallyImplyLeading: false,),



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




icon: Icon(_obscurePassword


? Icons.visibility


: Icons.visibility_off),




                       onPressed: (){


                         setState((){
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
 if (_isLoading)


                      const CircularProgressIndicator()



else
 ElevatedButton(



                      onPressed: _login,

                     child: const Text('Entrar'),
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