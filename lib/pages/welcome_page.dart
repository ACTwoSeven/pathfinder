import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/RegisterPage.dart';
import 'package:pathfinder/Pages/auth_page.dart';
import 'package:pathfinder/pages/main_menu.dart';
import 'package:pathfinder/widgets/app_large_text.dart';

import '../misc/colors.dart';
import '../widgets/app_text.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "welcome-one.png",
    "welcome-two.png",
    "welcome-three.png",
  ];

  List texts = [
    "Hola",
    "Como",
    "Estoy",
  ];

  List pages = [
    AuthPage(),
    RegisterPage(),
    MainMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index){
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/"+images[index]
                ),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "PathFinder"),
                      AppText(text: "Ecosistema de movilidad", size: 30,),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child:  AppText(
                          text: texts[index],
                          color: AppColors.textColor2,
                          size: 14,
                        ),
                      ),
                      SizedBox(height: 40,),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => pages[index]),
                          );
                        //ResponsiveButton(width: 120,);
                        },
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(3, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        width: 8,
                        height: index==indexDots?25:8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                              color:index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                        ),
                      );
                    }),
                  )
                ],
              )
            ),
          );
      }),
    );
  }
}
