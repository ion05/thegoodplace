import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:thegoodplace/loaders/creating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class AngryPage extends StatefulWidget {
  @override
  _AngryPageState createState() => _AngryPageState();
}

final random = Random();

class _AngryPageState extends State<AngryPage> {
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
              advices.add(element['advicetoangry'].toString());
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
    return loading
        ? CreatingLoader()
        : Scaffold(
            body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                HexColor('#ff8a78'),
                HexColor('#ff7275'),
                HexColor('#ff3f6f')
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Here's something to Help You Out!",
                        style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: "Nunito-Sans"),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Why are you angry ?',
                          focusColor: Colors.greenAccent[200],
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28.0)),
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(28.0)),
                          labelStyle: TextStyle(
                              fontFamily: 'Roboto-Condensed',
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      SizedBox(height: 50.0),
                      Column(
                        children: [
                          SizedBox(
                            width: 30.0,
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.mode_comment, color: Colors.black),
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: 'Submitted!',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  fontSize: 16.0);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )),
                            label: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: GradientText(
                                text: 'Submit',
                                colors: <Color>[
                                  HexColor('#ff8a78'),
                                  HexColor('#ff7275'),
                                  HexColor('#ff3f6f'),
                                ],
                                style: TextStyle(fontSize: 24.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton.icon(
                            icon:
                                Icon(Icons.trending_flat, color: Colors.black),
                            onPressed: () {
                              Navigator.pushNamed(context, '/scream');
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )),
                            label: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: GradientText(
                                text: 'Scream Zone',
                                colors: <Color>[
                                  HexColor('#ff8a78'),
                                  HexColor('#ff7275'),
                                  HexColor('#ff3f6f'),
                                ],
                                style: TextStyle(fontSize: 24.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text("Here's some advice for you!"),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(advicetoshow ,style: TextStyle(color: Colors.white,)),
                      SizedBox(height: 5.0,),
                      Text(
                          'Check out our Spotify playlist that might create the vibe for you',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          )),
                      SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DX7yRWDZJQ3Yz?si=-xt9mYF6R36YzfbLmEkwvw&utm");
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Image(
                                    height: 55.0,
                                    width: 55.0,
                                    image: AssetImage("assets/images/vibe.png"),
                                  ),
                                  SizedBox(
                                    width: 7.5,
                                  ),
                                  Text(
                                    'Vibe',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'OpenSans-Condensed',
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0,
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                            width: 10.0,
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DX3rxVfibe1L0?si=JzsnHyQ8Qs69ApAMHt39KA&utm");
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Image(
                                    height: 55.0,
                                    width: 55.0,
                                    image: AssetImage("assets/images/mood.png"),
                                  ),
                                  SizedBox(
                                    width: 7.0,
                                  ),
                                  Text('Mood Booster',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'OpenSans-Condensed',
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    height: 2.0,
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DX4mWCZw6qYIw?si=df151ed3cd514a78&nd=1");
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Image(
                                    height: 55.0,
                                    width: 55.0,
                                    image: AssetImage(
                                        "assets/images/songstoscream.png"),
                                  ),
                                  SizedBox(
                                    width: 7.0,
                                  ),
                                  Text('Songs to Scream',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'OpenSans-Condensed',
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                    height: 2.0,
                                    width: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ));
  }
}
