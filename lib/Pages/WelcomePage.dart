import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pathfinder/Pages/auth_page.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to login screen
                Navigator.push(context,MaterialPageRoute(builder: (_)=> AuthPage()));
              },
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to registration screen
                Navigator.push(context,MaterialPageRoute(builder: (_)=> AuthPage()));
              },
              child: Text('Registrarse'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Sign in anonymously
                UserCredential result =
                await FirebaseAuth.instance.signInAnonymously();
                User? user = result.user;
                if (user != null) {
                  // Navigate to home screen
                  Navigator.push(context,MaterialPageRoute(builder: (_)=> AuthPage()));
                  print("Anonymo registrado");
                }
              },
              child: Text('Ingresar como visitante'),
            ),
          ],
        ),
      ),
    );
  }
}
