import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final correo = TextEditingController();
  final pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _mostrarContrasena = false;
  String userName = '';
  String userId ='';


  void signUserIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: correo.text,
        password: pass.text);
  }

  void _mostrarAlerta(BuildContext context, String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            ElevatedButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleMostrarContrasena(bool value) {
    setState(() {
      _mostrarContrasena = value;
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('image/user.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: correo,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Correo',
                  hintText: 'Digite su correo electronico',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: pass,
                obscureText: !_mostrarContrasena,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _mostrarContrasena
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      _toggleMostrarContrasena(!_mostrarContrasena);
                    },
                  ),
                  hintText: 'Digite su contraseña',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 50, right: 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    print('Ingresando...');
                    signUserIn;
                  },
                  child: Text('Ingresar'),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            //Continua con
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(children: [
                Expanded(child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                      'O inicia sesión con:',
                      style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
                Expanded(child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ))
              ],),
            ),

            const SizedBox(height: 50,),
            //Google sign in button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset(
                  'lib/Images/google_logo.png',
                  height: 40,),
                const SizedBox(),
            ],),

            const SizedBox(height: 50,),

            //Registrate
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'No estás registrado?',
                    style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4,),
                Text(
                  'Registrate!',
                  style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold
                  ),
                )
              ],
            )
          ]
          ),
        ),
      ),
    );
  }
}