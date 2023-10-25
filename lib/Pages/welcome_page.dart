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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puestos de información'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
