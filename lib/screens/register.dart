import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_button/sign_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:thegoodplace/loaders/creating.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  final _database = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var signInButton = SignInButton(
      buttonType: ButtonType.google,
      imagePosition: ImagePosition.left,
      buttonSize: ButtonSize.large,
      btnTextColor: HexColor('#cbc0d3'),
      btnColor: Colors.white,
      width: 200,
      //[width] Use if you change the text value.
      btnText: 'Login Google',

      onPressed: () {},
    );
    return loading
        ? CreatingLoader()
        : Scaffold(
            appBar: AppBar(
              title: Text('Register'),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor('#16e16e'), HexColor('#188a8d')],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        print('click');
                        setState(() {
                          loading = true;
                        });
                        final GoogleSignInAccount googleUser =
                            await GoogleSignIn().signIn();
                        final GoogleSignInAuthentication googleAuth =
                            await googleUser.authentication;
                        final credential = GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken);
                        try {
                          await _auth.signInWithCredential(credential);
                          final user = _auth.currentUser;
                          await _database
                              .collection('users')
                              .doc(user.uid)
                              .set({
                            "name": user.displayName,
                            "email": user.email,
                          });
                          setState(() {
                            loading = false;
                          });
                        } catch (e) {
                          print(e.toString());
                          return 'Some Error Occured';
                        }
                      },
                      //TODO: Replace this with signInButton
                      child: Text('Sign In'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
