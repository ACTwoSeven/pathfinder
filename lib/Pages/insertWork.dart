import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../misc/colors.dart';
import 'HomePage.dart';

class ccreateWork extends StatefulWidget {
  const ccreateWork({super.key});

  @override
  State<ccreateWork> createState() => ccreateWorkState();
}

class ccreateWorkState extends State<ccreateWork> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  File? file;
  //final _database = FirebaseDatabase.instance.ref();
  //final user = FirebaseAuth.instance.currentUser!;
  //ImagePicker image = ImagePicker();
  DatabaseReference? dbRef;
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('User');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir puesto de trabajo',
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Nombre del puesto de trabajo (ej. Iglesia Cristo Rey)',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: number,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Dirección del puesto (ej. Cll 9#18-20)',
              ),
              maxLength: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                uploadFile();
              },
              color: AppColors.mainColor,
              child: const Text(
                "Añadir puesto",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
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
          'direccion': number.text,
        };
        dbRef!.push().set(ruta).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
          );
        });
    } on Exception catch (e) {
      print(e);
    }
  }
}