import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thegoodplace/loaders/creating.dart';
import 'package:thegoodplace/screens/home.dart';
import 'package:thegoodplace/screens/register.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final _auth = FirebaseAuth.instance;
  // Future<void> signInSilently() async {
  //   Future<GoogleSignInAccount> googleUser = GoogleSignIn().signInSilently();
  //   final GoogleSignInAuthen;
  //                       final credential = GoogleAuthProvider.credential(
  //                           accessToken: googleAuth.accessToken,
  //                           idToken: googleAuth.idToken);
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            // try {
            //   signInSilently();
            // } catch (e) {
            //   print(e.toString());
            //   return RegisterScreen();
            // }
            return RegisterScreen();
          } else {
            return HomeScreen();
          }
        }
        return CreatingLoader();
      },
    );
  }
}
