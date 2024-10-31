import 'package:flutter/material.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {



 final _emailController = TextEditingController();
   final _formKey = GlobalKey<FormState>();




   bool _isLoading = false;
   @override


    void dispose() {

      _emailController.dispose();

 super.dispose();
 }





Future<void> _resetPassword() async {


if (_formKey.currentState!.validate()) {




     setState(() {



    _isLoading = true;

     });




// ignore: avoid_print


    print('Enviando email de redefinição para: ${_emailController.text}'); // Simula o envio




// Adicione aqui a lógica para enviar o email de redefinição (ex: API call)

        // Aguarde um pequeno período para simular o processamento

   await Future.delayed(const Duration(seconds: 2));


 setState(() {

       _isLoading = false;




 });




      if (mounted) { // Certifique-se de que a tela ainda esteja montada




ScaffoldMessenger.of(context).showSnackBar(




  const SnackBar(content: Text('Email de redefinição de senha enviado (Simulação). Verifique as instruções em seu email.')),

     );



//ignore: use_build_context_synchronously

       Navigator.pop(context);



  }

     }




   }




 @override
  Widget build(BuildContext context) {

return Scaffold(

       appBar: AppBar(title: const Text('Recuperar Senha')),

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
               const SizedBox(height: 24),





if (_isLoading)




    const Center(child: CircularProgressIndicator())




  else



                 ElevatedButton(



                onPressed: _resetPassword,

                     child: const Text('Redefinir Senha'),

     ),





              ],
),






 ),

    ),



 );


 }


}