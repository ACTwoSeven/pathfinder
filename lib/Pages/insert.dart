import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/RoutesPage.dart';
import 'package:pathfinder/misc/colors.dart';

class ccreate extends StatefulWidget {
  String Contact_Key;
  ccreate({super.key, required this.Contact_Key});
  @override
  State<ccreate> createState() => ccreateState();
}

class ccreateState extends State<ccreate> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  File? file;
  var url;
  DatabaseReference? dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User/${widget.Contact_Key}/rutas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Añadir rutas',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nombre de la ruta',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Código de la ruta',
              ),
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                  uploadFile();
              },
              child: Text(
                "Añadir ruta",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              color: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }
  uploadFile() async {
    try {
        Map<String, String> ruta = {
          'name': name.text,
          'number': number.text,
          'hora': 'N/A'
        };

        dbRef!.push().set(ruta).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => RoutesPage(Contact_Key: widget.Contact_Key,),
            ),
          );
        });

    } on Exception catch (e) {
      print(e);
    }
  }
}

