import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/HomePage.dart';
//import 'package:image_picker/image_picker.dart';

//import 'main.dart';

class UpdateRecord extends StatefulWidget {
  String Contact_Key;
  UpdateRecord({required this.Contact_Key});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}
class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController contactName = new TextEditingController();
  TextEditingController contactNumber = new TextEditingController();
  TextEditingController placaBus = new TextEditingController();
  var url;
  var url1;
  File? file;
  //ImagePicker image = ImagePicker();
  DatabaseReference? db_Ref;
  DatabaseReference? db_Ref1;

  @override
  void initState() {
    super.initState();
    db_Ref = FirebaseDatabase.instance.ref().child('User');
    db_Ref1 = FirebaseDatabase.instance.ref().child('User/'+widget.Contact_Key+'/Buses');
    Contactt_data();
  }

  void Contactt_data() async {
    DataSnapshot snapshot = await db_Ref!.child(widget.Contact_Key).get();

    Map User = snapshot.value as Map;

    setState(() {
      contactName.text = User['name'];
      contactNumber.text = User['number'];
      url = 'abc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: url == null
                    ? MaterialButton(
                  height: 100,
                  child: Image.file(
                    file!,
                    fit: BoxFit.fill,
                  ),
                  onPressed: () {
                    //getImage();
                  },
                )
                    : MaterialButton(
                  height: 100,
                  child: CircleAvatar(
                    maxRadius: 100,
                    backgroundImage: NetworkImage(
                      url,
                    ),
                  ),
                  onPressed: () {
                    //getImage();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: contactName,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Name',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: contactNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Number',
              ),
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: placaBus,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Placa de bus',
              ),
              maxLength: 10,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                // getImage();
                if (file != null) {
                  uploadFile();
                } else {
                  directupdate();
                }
              },
              child: Text(
                "Update",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              color: Colors.indigo[900],
            ),
          ],
        ),
      ),
    );
  }


  uploadFile() async {
    try {
      url1 = 'xxxx';
      setState(() {
        url1 = url1;
      });
      if (contactName.text != null) {
        Map<String, String> User = {
          'name': contactName.text,
          'number': contactNumber.text,
          'url': url1,
        };
        db_Ref1!.push().set(User).whenComplete(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
          );
        });
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  directupdate() {
    if (url != null) {
      Map<String, String> Update = {
        'name': contactName.text,
        'number': contactNumber.text,
        'url': url,
        'hora': DateTime.now().hour.toString()+':'+DateTime.now().minute.toString(),
      };
      Map<String, String> bus = {
        'placa': placaBus.text,
        'hora': DateTime.now().hour.toString()+':'+DateTime.now().minute.toString(),
        'ruta': contactNumber.text,
      };
      db_Ref!.child(widget.Contact_Key).update(Update).whenComplete((){
          db_Ref1!.push().set(bus).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(),
          ),
        );
      });});
    }
  }
}