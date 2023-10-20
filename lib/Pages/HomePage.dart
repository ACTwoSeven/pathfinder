import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/update.dart';

import 'insert.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _database = FirebaseDatabase.instance.reference();

  String? _workplace;
  List<String>? _routes;

  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }
  void _saveData(ruta) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save data to Firebase Realtime Database
      final user = FirebaseAuth.instance.currentUser!;
      final data = {
        'workplace': _workplace,
        'routes': ruta,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      _database.child(user.email!).push().set(data);

      // Clear form
      setState(() {
        _workplace = null;
        _routes = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference db_Ref =
    FirebaseDatabase.instance.ref().child('User');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ccreate(),
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
        title: Text(
          'Pathfinder - Datero',
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
          Map rutas = snapshot.value as Map;
          rutas['key'] = snapshot.key;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateRecord(
                    Contact_Key: rutas['key'],
                  ),
                ),
              );
              print(rutas['key']);
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
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
                      _saveData(rutas['key']);
                    },
                  ),
                  title: Text(
                    rutas['name'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    rutas['number'],
                    style: TextStyle(
                      fontSize: 25,
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
