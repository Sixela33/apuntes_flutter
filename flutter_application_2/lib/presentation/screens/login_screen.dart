import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

Map<String, String> usuarios = {
    'juan.perez@example.com': 'juan.perez@example.com',
    'laura.gomez@example.com': 'QWERr1#',
    'carlos.rodriguez@example.com': 'QWERr1#',
    'ana.martinez@example.com': 'QWERr1#',
    'diego.lopez@example.com': 'QWERr1#'
  };

class LoginScreen extends StatelessWidget {
  static String name ='LoginScreen';

  const LoginScreen({super.key});

  static TextEditingController inputUserController = TextEditingController();
  static TextEditingController inputPasswordController = TextEditingController();

  bool validarUsuarioCorrecto (String email, String contrasena) {
    return true;
    bool result = false;
    if(usuarios.containsKey(email)) {
      if(usuarios[email] == contrasena){
        result = true;
      }
    }
    return result;
  }

  bool validateEmail (String email) {
    return true;
    return EmailValidator.validate(email);
  }

  bool validatePassword (String password) {
    return true;
    String pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('login'),
            const SizedBox(height: 10,),
            TextField(
              controller: inputUserController,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            const SizedBox(height: 10,),
            TextField(
              controller: inputPasswordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                  
                if(!validateEmail(inputUserController.text)){
                  print('email invalido');
                  return;
                }

                if(!validatePassword(inputPasswordController.text)){
                  print('contrasena invalida');
                  return;
                }

                if(validarUsuarioCorrecto(inputUserController.text, inputPasswordController.text)){
                  context.pushNamed(HomeScreen.name,
                    extra: inputUserController.text);
                } else {
                  print('cuenta invalida');
                }

              }, 
              child: const Text('login')
            )
          ],
        ),
      )
        
    );
  }
}