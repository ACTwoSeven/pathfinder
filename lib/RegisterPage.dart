import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String name = '';
  String id = '';
  String email = '';
  String password = '';

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(hintText: 'Enter your name'),
            ),
            TextField(
              onChanged: (value) {
                id = value;
              },
              decoration: InputDecoration(hintText: 'Enter your ID'),
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            ElevatedButton(
              onPressed: () async {
                UserCredential userCredential =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  user.updateDisplayName(name);
                  user.updatePhotoURL(id);
                }
              },
              child: Text('Register with Email and Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                UserCredential userCredential = await signInWithGoogle();
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  user.updateDisplayName(name);
                  user.updatePhotoURL(id);
                }
              },
              child: Text('Register with Google'),
            ),
          ],
        ),
      ),
    );
  }
}

