import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:thegoodplace/loaders/creating.dart';
import 'package:url_launcher/url_launcher.dart';

class HappyPage extends StatefulWidget {
  @override
  _HappyPageState createState() => _HappyPageState();
}

class _HappyPageState extends State<HappyPage> {
  @override
  Widget build(BuildContext context) {
    final double statusbarheight = MediaQuery.of(context).padding.top + 10.0;
    return Scaffold(
      // appBar: AppBar(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10.0),
      //   ),
      //   backgroundColor: HexColor("#1aff66"),
      //   title: Text(
      //     "Here's What You Can Do",
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [HexColor('#16e16e'), HexColor('#188a8d')],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: statusbarheight),
                height: 100.0 + statusbarheight,
                width: double.infinity,
                child: Text(
                  "Here's What You Can Do",
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 25.0, fontFamily: 'OpenSans-Condensed'),
                ),
              ),
              HappyForm()
            ],
          ),
        ),
      ),
    );
  }
}

class HappyForm extends StatefulWidget {
  @override
  _HappyFormState createState() => _HappyFormState();
}

class _HappyFormState extends State<HappyForm> {
  final key = GlobalKey<FormState>();
  final _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String whyhappy;
  String advicetosad;
  String advicetoangry;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? CreatingLoader()
        : Container(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        whyhappy = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Reason cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        suffixIcon:
                            Icon(Icons.sentiment_very_satisfied_outlined),
                        // helperText: 'Why are you happy today?',
                        labelText: 'Why are you feeling happy today ?',
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        labelStyle: TextStyle(
                          fontFamily: 'Roboto-Condensed',
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        advicetosad = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Reason cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.sentiment_dissatisfied),
                        // helperText: 'Why are you happy today?',
                        labelText:
                            'How will you try to make a sad person happy?',
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        labelStyle: TextStyle(
                          fontFamily: 'Roboto-Condensed',
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        advicetoangry = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Reason cannot be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.sentiment_very_dissatisfied),
                        // helperText: 'Why are you happy today?',
                        labelText:
                            'How will you try to make an angry person happy?',
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28.0)),
                        labelStyle: TextStyle(
                          fontFamily: 'Roboto-Condensed',
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                        onPressed: () async {
                          key.currentState.save();
                          if (key.currentState.validate()) {
                            final _user = _auth.currentUser;
                            setState(() {
                              loading = true;
                            });
                            await _database
                                .collection('happyppl')
                                .doc(_user.uid)
                                .set({
                              "whyhappy": whyhappy,
                              "advicetosad": advicetosad,
                              "advicetoangry": advicetoangry,
                            }).then((value) => print('Response Noted'));
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Text('Submit',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      thickness: 2.5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Here are some spotify playlists for you',
                      style: TextStyle(
                          fontFamily: 'OpenSans-Condensed', fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(children: [
                      ElevatedButton(
                          onPressed: () {
                            launch(
                                "https://open.spotify.com/playlist/37i9dQZF1DXdPec7aLTmlC");
                          },
                          child: Row(
                            children: [
                              Image(
                                height: 75.0,
                                width: 75.0,
                                image:
                                    AssetImage("assets/images/happyhits.jpg"),
                              ),
                              Text('Happy Hits',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontFamily: 'OpenSans-Condensed')),
                              SizedBox(
                                height: 2.0,
                                width: 10.0,
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            launch(
                                "https://open.spotify.com/playlist/37i9dQZF1DXcEKFjZJYZcc");
                          },
                          child: Row(
                            children: [
                              Image(
                                height: 75.0,
                                width: 75.0,
                                image: AssetImage(
                                    "assets/images/feelgoodpiano.jpg"),
                              ),
                              Text('Feel Good Piano',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontFamily: 'OpenSans-Condensed')),
                              SizedBox(
                                height: 2.0,
                                width: 10.0,
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white))),
                      SizedBox(height: 10.0),
                    ]),
                  ],
                ),
              ),
            ));
  }
}
