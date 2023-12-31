import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pathfinder/Pages/auth_page.dart';
import '../misc/colors.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});



  @override
  _RegisterPageState createState() => _RegisterPageState();

}


class _RegisterPageState extends State<RegisterPage> {
  final correo = TextEditingController();
  final pass = TextEditingController();
  final confirmpass = TextEditingController();
  bool _mostrarContrasena = false;
  String userName = '';
  String userId ='';


  void signUserUp() async {
    //Comprobar campos vacíos
    if (correo.text.isNotEmpty && pass.text.isNotEmpty) {
      //Intente crear el user
      try {
        if(pass.text==confirmpass.text){
          //Circulo de progreso
          showDialog(
              context: context,
              builder: (context){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: correo.text,
            password: pass.text,
          );
          //Cierra el circulo de progreso
          Navigator.pop(context);
        }else{
          _mostrarAlerta(context, "Las contraseñas no son iguales.", "Las contraseñas ingresadas son diferentes, confirme su contraseña de forma adecuada.");
        }
        //Mostrar errores
      } on FirebaseAuthException catch (e) {
        if(e.code == 'weak-password'){
          _mostrarAlerta(context, "La contraseña es demasiado débil.", "La contraseña debe contener al menos 6 carácteres.");
        }else{
          print(e.code);
        }
      }
    } else {
      // Alerta de campo vacío
      print("Están vacíos");
      _mostrarAlerta(context, "Hay un campo vacío.", "Rellena todos los campos requeridos para iniciar sesión!");
    }
  }

  //Sistema de alertas en la pantalla
  void _mostrarAlerta(BuildContext context, String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            ElevatedButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Función detectar cambios de mostrar u ocultar contraseña
  void _toggleMostrarContrasena(bool value) {
    setState(() {
      _mostrarContrasena = value;
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        child: Image.asset('img/register-one.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Crea una cuenta con nosotros:',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: correo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          )
                      ),
                        labelText: 'Correo',
                        labelStyle: TextStyle(color: AppColors.mainColor),
                        hintText: 'Digite su correo electronico',
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: AppColors.mainColor,
                      ),
                    ),
                  ),
                  //Ingresa la contraseña
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: pass,
                      obscureText: !_mostrarContrasena,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )
                        ),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: AppColors.mainColor),
                        prefixIcon: Icon(Icons.password),
                        prefixIconColor: AppColors.mainColor,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarContrasena
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _toggleMostrarContrasena(!_mostrarContrasena);
                          },
                        ),
                        suffixIconColor: AppColors.mainColor,
                        hintText: 'Digite su contraseña',
                      ),
                    ),
                  ),
                  //Confirma la contraseña
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: confirmpass,
                      obscureText: !_mostrarContrasena,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )
                        ),
                        labelText: 'Confirma la contraseña',
                        labelStyle: TextStyle(color: AppColors.mainColor),
                        prefixIcon: Icon(Icons.password),
                        prefixIconColor: AppColors.mainColor,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _mostrarContrasena
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _toggleMostrarContrasena(!_mostrarContrasena);
                          },
                        ),
                        suffixIconColor: AppColors.mainColor,
                        hintText: 'Digite su contraseña',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30, right: 10),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print('Registrando...');
                          signUserUp();
                          Navigator.push(context,MaterialPageRoute(builder: (_)=> AuthPage()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('Registrate'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  //Continua con
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(children: [
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'O inicia sesión con:',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))
                    ],),
                  ),

                  const SizedBox(height: 25,),
                  //Google sign in button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/Images/google_logo.png',
                        height: 40,),
                      const SizedBox(),
                    ],),

                  const SizedBox(height: 25,),

                  //Registrate
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes una cuenta?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Inicia sesión aquí!',
                          style: TextStyle(
                              color: AppColors.mainColor, fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }
}

