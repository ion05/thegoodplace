import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
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
    var advices = [
      'Tomorrow is a new day'
    ];
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

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.top;
    return loading
        ? CreatingLoader()
        : Scaffold(
            body: Container(
              padding: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  HexColor('#a870e0'),
                  HexColor('#8e53c9'),
                  HexColor('#c953c1'),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: SingleChildScrollView(
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
                    Text(advicetoshow),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("Wanna play some games ?", style: TextStyle(fontFamily: 'Nunito-Sans', fontSize: 20.0)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          height: 200.0,
                          // autoPlay: true,
                          autoPlayInterval: Duration(seconds: 10),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 2.0,
                        ),
                        items: [
                          Item1(),
                          Item2(),
                          Item3(),
                          Item4()
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Container(
                      //       width: 10.0,
                      //       height: 10.0,
                      //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ]),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Here are Some Spotify Playlists for you',
                      style: TextStyle(fontFamily: 'Nunito-Sans', fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            launch("https://open.spotify.com/playlist/37i9dQZF1DX2pSTOxoPbx9?si=nkpyyJFLRl-DwL-orODvHA&utm_source=copy-link");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                  image: AssetImage("assets/images/darkstormy.png"),
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
                            launch("https://open.spotify.com/playlist/37i9dQZF1DX3YSRoSdA634?si=YOfeECGmRTCy8JSHGu9GGg&utm_source=copy-link");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                  image: AssetImage("assets/images/lifesucks.png"),
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
                            launch("https://open.spotify.com/playlist/37i9dQZF1DX2x1COalpsUi?si=c692d291c6ee45d0");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                                  image: AssetImage("assets/images/lifesucks.png"),
                                ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Text('Happy-O-Happy',
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
                  ],
                ),
              ),
            ),
          );
  }
}

class Item1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 40.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/game1.png'),
                height: 150.0,
                width: 150.0,
              )
            ],
          ),
          SizedBox(
            width: 50.0,
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 40.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/game2.png'),
                height: 150.0,
                width: 150.0,
              )
            ],
          ),
          SizedBox(
            width: 50.0,
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 40.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/game3.png'),
                height: 150.0,
                width: 150.0,
              )
            ],
          ),
          SizedBox(
            width: 50.0,
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class Item4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: 40.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/game4.png'),
                height: 150.0,
                width: 150.0,
              )
            ],
          ),
          SizedBox(
            width: 50.0,
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
