import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/RoutesPage.dart';
import 'package:pathfinder/Pages/insertWork.dart';

import '../misc/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference db_Ref =
    FirebaseDatabase.instance.ref().child('User');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ccreateWork(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text(
          'Puestos de información',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: AppColors.mainColor,
      ),

      body: FirebaseAnimatedList(
        query: db_Ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Map User = snapshot.value as Map;
          User['key'] = snapshot.key;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RoutesPage(
                    Contact_Key: User['key'],
                  ),
                ),
              );
              print(User['key']);
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: AppColors.subColor,
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.mainColor,
                    ),
                    onPressed: () {
                      //_saveData(User['key']);
                    },
                  ),
                  title: Text(
                    User['name'],
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Dirección: ${User['direccion']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}