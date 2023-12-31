import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pathfinder/Pages/WelcomePage.dart';
import 'package:pathfinder/Pages/auth_page.dart';
import 'package:pathfinder/pages/main_menu.dart';
import 'Pages/RegisterPage.dart';
import 'Pages/LoginPage.dart';
import 'firebase/firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home : MainMenu(),
      title: 'Pathfinder',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
    );
  }
}