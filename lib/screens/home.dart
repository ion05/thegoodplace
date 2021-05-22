import 'dart:ui';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Screen'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.exit_to_app),
      //       onPressed: () async {
      //         await _auth.signOut();
      //       },
      //     )
      //   ],
      // ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [HexColor('#8BC6EC'), HexColor('#9599E2')],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'The Good Place',
              style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.white,
                  // fontWeight: FontWeight.w700,
                  fontFamily: "Nunito-Sans"),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Lorem Ipsum',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/happy');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: GradientText(
                  text: 'Happy',
                  colors: <Color>[HexColor('#8BC6EC'), HexColor('#9599E2')],
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sad');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  )),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: GradientText(
                  text: 'Sad',
                  colors: <Color>[HexColor('#8BC6EC'), HexColor('#9599E2')],
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
