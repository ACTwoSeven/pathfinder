import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/LoginPage.dart';
import 'package:pathfinder/Pages/WelcomePage.dart';
import 'HomePage.dart';
import 'LoginOrRegisterPage.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //Usuario is logged
          if (snapshot.hasData){
            print(snapshot.data);
            return HomePage();
          }
          else{
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}