import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'RegisterPage.dart';
import 'firebase_options.dart';

void main() async{
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
      title: 'Página principal',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Página principal'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Acción para iniciar sesión
                },
                child: Text('Iniciar sesión'),
              ),
              ElevatedButton(
                onPressed: () {
                  print('Entrando a registro');
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterPage()),
              );
              },
                child: Text('Registrarse'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Acción para ingresar como invitado
                },
                child: Text('Ingresar como invitado'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
