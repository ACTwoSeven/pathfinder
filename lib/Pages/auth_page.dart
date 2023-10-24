import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/HomePage.dart';
import 'LoginOrRegisterPage.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //User is logged
          if (snapshot.hasData){
            if (kDebugMode) {
              print(snapshot.data);
            }
            return HomePage();
          }
          else{
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}