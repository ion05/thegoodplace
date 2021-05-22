import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import 'package:thegoodplace/loaders/creating.dart';

class SadPage extends StatefulWidget {
  @override
  _SadPageState createState() => _SadPageState();
}

final random = Random();

class _SadPageState extends State<SadPage> {
  final _database = FirebaseFirestore.instance;
  String advicetoshow = "";
  bool loading = false;
  Future<String> getDocuments() async {
    var advices = ['Tomorrow is a new day'];
    setState(() {
      loading = true;
    });
    final snapshot = await _database
        .collection('happyppl')
        .get()
        .then((value) => value.docs.forEach((element) {
              advices.add(element['advicetosad'].toString());
            }))
        .then((value) {
      setState(() {
        loading = false;
      });
      int range = advices.length;
      int advicenumber = random.nextInt(range);
      setState(() {
        advicetoshow = advices[advicenumber];
      });
    });
  }

  @override
  void initState() {
    getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.top;
    return loading
        ? CreatingLoader()
        : Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [HexColor('#8BC6EC'), HexColor('#9599E2')],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              padding: EdgeInsets.only(top: padding + 30.0),
              child: Column(
                children: [
                  Text(
                    "Here are somethings to make you feel better",
                    style: TextStyle(fontFamily: 'Nunito-Sans'),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text("Here's some advice!"),
                  TextButton(
                      onPressed: () {
                        getDocuments();
                      },
                      child: Text('Hi')),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(advicetoshow)
                ],
              ),
            ),
          );
  }
}
