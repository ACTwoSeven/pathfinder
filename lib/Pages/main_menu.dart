
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/LoginOrRegisterPage.dart';
import 'package:pathfinder/Pages/LoginPage.dart';
import 'package:pathfinder/Pages/RegisterPage.dart';
import 'package:pathfinder/Pages/auth_page.dart';
import 'package:pathfinder/pages/welcome_page.dart';

import '../misc/colors.dart';

class MainMenu extends StatelessWidget {
  List images = [
    "welcome-one.png",
    "welcome-two.png",
    "welcome-three.png",
  ];

  final List<String> texts = [
    "Con nuestra aplicación siendo funcionario de control o datero podras registrar la información importante de las rutas en función a la empresa que hagas parte.",
    "La aplicación no solo te permitira registrar la información, si no que automaticamente enviara un informe diario a la empresa que hagas parte.",
    "Adicionalmente cuenta con una seccion para visitantes, donde podras conocer los tiempos aproximados de rutas de conveniencia."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/" + images[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PathFinder",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Ecosistema de movilidad",
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: Text(
                          texts[index],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AuthPage()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: Text('Iniciar Sesión'),
                        ),
                        ),
                      Container(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const WelcomePage()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: Text('Registrarse'),
                        ),
                      ),

                        Container(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () async {
                              UserCredential result =
                                  await FirebaseAuth.instance.signInAnonymously();
                              User? user = result.user;
                              if (user != null) {
                                // Navigate to home screen
                                Navigator.push(context,MaterialPageRoute(builder: (_)=> AuthPage()));
                                print("Anonymo registrado");
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text("Visitantes"),
                            ),
                          ),
                          ],
                        ),
                  Column(
                    children: List.generate(3, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        width: 8,
                        height: index == indexDots ? 25 : 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                            color:index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}