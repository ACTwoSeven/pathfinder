import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/RoutesPage.dart';

import '../misc/colors.dart';

class UpdateRecord extends StatefulWidget {
  String Contact_Key;
  String Rutas_Key;

  UpdateRecord({super.key, required this.Contact_Key,required this.Rutas_Key});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}
class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController contactName = new TextEditingController();
  TextEditingController contactNumber = new TextEditingController();
  TextEditingController placaBus = new TextEditingController();
  //ImagePicker image = ImagePicker();
  DatabaseReference? db_Ref;
  DatabaseReference? db_Ref1;

  @override
  void initState() {
    super.initState();
    db_Ref = FirebaseDatabase.instance.ref().child('User/'+widget.Contact_Key+'/rutas');
    db_Ref1 = FirebaseDatabase.instance.ref().child('User/'+widget.Contact_Key+'/rutas/${widget.Rutas_Key}/buses');
    Contactt_data();
  }

  void Contactt_data() async {
    DataSnapshot snapshot = await db_Ref!.child(widget.Rutas_Key).get();
    Map User = snapshot.value as Map;

    setState(() {
      contactName.text = User['name'];
      contactNumber.text = User['number'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
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
              controller: contactName,
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Placa de bus',
              ),
              maxLength: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                  directupdate();
              },
              color: AppColors.mainColor,
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  directupdate() {
    var hora;
    if(DateTime.now().hour>12)
    {
      if(DateTime.now().minute<10)
      {
        hora='${(DateTime.now().hour-12).toString()}:0${DateTime.now().minute} PM';
      }else{
        hora='${(DateTime.now().hour-12).toString()}:${DateTime.now().minute} PM';
      }
    }else if(DateTime.now().minute<10){
      hora='${(DateTime.now().hour).toString()}:0${DateTime.now().minute} AM';
    }else{
      hora='${(DateTime.now().hour).toString()}:${DateTime.now().minute} AM';
    }

      Map<String, String> Update = {
        'name': contactName.text,
        'number': contactNumber.text,
        'hora': hora,
      };
      Map<String, String> bus = {
        'placa': placaBus.text,
        'hora': hora,
        'ruta': contactNumber.text,
      };
      db_Ref!.child(widget.Rutas_Key).update(Update).whenComplete((){
          db_Ref1!.push().set(bus).whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => RoutesPage(Contact_Key: widget.Contact_Key,),
          ),
        );
      });});
    }
}