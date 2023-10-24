import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/update.dart';

import 'insert.dart';

class RoutesPage extends StatefulWidget {
  String Contact_Key;
  RoutesPage({required this.Contact_Key});

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {


  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference db_Ref =
    FirebaseDatabase.instance.ref().child('User/${widget.Contact_Key}/rutas');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ccreate(
                Contact_Key: widget.Contact_Key,
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signUserOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: const Text(
          'Rutas',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.indigo[900],
      ),
      body: FirebaseAnimatedList(
        query: db_Ref,
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Map Rutas = snapshot.value as Map;
          Rutas['key'] = snapshot.key;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateRecord(
                    Contact_Key: widget.Contact_Key, Rutas_Key: Rutas['key'],
                  ),
                ),
              );
              print(Rutas['key']);
            },
           child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue[900],
                    ),
                    onPressed: () {
                      //_saveData(User['key']);
                    },
                  ),
                  title: Text(
                    Rutas['name'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Última hora registrada: '+Rutas['hora'],
                    style: TextStyle(
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
