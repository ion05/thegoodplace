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
  bool loading = false;
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
              centerTitle: true,
            ),
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style:
                          TextStyle(fontFamily: 'Nunito-Sans', fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    EmergencyContactDetails(),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class EmergencyContactDetails extends StatefulWidget {
  @override
  _EmergencyContactDetailsState createState() =>
      _EmergencyContactDetailsState();
}

class _EmergencyContactDetailsState extends State<EmergencyContactDetails> {
  int contacts = 3;
  final _auth = FirebaseAuth.instance;
  final _key = GlobalKey<FormState>();
  bool loading = false;
  var contactdetails = [];
  final _database = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Form(
          key: _key,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: contacts,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  TextFormField(
                    onSaved: (val) {
                      contactdetails.add(val);
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.mail),
                      labelText: "Emergency contact ${index + 1}",
                      hintText: 'Enter the email of your emergency contact',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28.0)),
                      labelStyle: TextStyle(
                        fontFamily: 'Roboto-Condensed',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                contacts += 1;
              });
            },
            label: Text(
              'Add A Contact',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(Icons.add, color: Colors.white),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue[700]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0))),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            _key.currentState.save();
            if (_key.currentState.validate()) {
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
                await _database.collection('users').doc(user.uid).set({
                  'name': user.displayName,
                  "email": user.email,
                  'contacts': contactdetails,
                });
              } catch (e) {
                print(e.toString());
                return 'Some Error Occurred';
              }
            }
          },
          //TODO: Replace this with signInButton
          child: Text('Sign In'),
        )
      ]),
    );
  }
}
