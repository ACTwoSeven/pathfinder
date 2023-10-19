import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/RegisterPage.dart';

import 'LoginPage.dart';


class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  //Inicializar mostrar la página login
  bool showloginPage = true;

  // Cambiar entre página de login y registro
  void togglePages(){
    setState(() {
      showloginPage = !showloginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showloginPage){
      return LoginPage(
        onTap: togglePages,
      );
    }else {
      return RegisterPage();
    }
    }
  }


