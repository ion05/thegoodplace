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

  int _currentIndex = 0;

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
                    Text("Wanna play some games ?",
                        style: TextStyle(
                            fontFamily: 'Nunito-Sans', fontSize: 20.0)),
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
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 2.0,
                        ),
                        items: [Item1(), Item2()],
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
                      style:
                          TextStyle(fontFamily: 'Nunito-Sans', fontSize: 15.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 2.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DX2pSTOxoPbx9?si=eT9qOIiUTIifeoKakII1DA&utm_source=copy-link&nd=1");
                            },
                            child: Row(
                              children: [
                                Image(
                                  height: 75.0,
                                  width: 75.0,
                                  image: AssetImage(
                                      "assets/images/darkstormy.jpg"),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Dark & Stormy',
                                    style: TextStyle(
                                        fontSize: 18.0,
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
                            )),
                        ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DX3YSRoSdA634?si=i9KfcfHmQFGOw96W2PL_dA&utm_source=copy-link&nd=1");
                            },
                            child: Row(
                              children: [
                                Image(
                                  height: 75.0,
                                  width: 75.0,
                                  image:
                                      AssetImage("assets/images/lifesucks.jpg"),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Life Sucks',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'OpenSans-Condensed')),
                                SizedBox(
                                  height: 2.0,
                                  width: 12.0,
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DWVrtsSlLKzro?si=z5IfZdzuTu6_izwGVbarYQ&utm_source=copy-link");
                            },
                            child: Row(
                              children: [
                                Image(
                                  height: 75.0,
                                  width: 75.0,
                                  image:
                                      AssetImage("assets/images/sadbeats.jpg"),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Sad Beats',
                                    style: TextStyle(
                                        fontSize: 18.0,
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
                            )),
                        ElevatedButton(
                            onPressed: () {
                              launch(
                                  "https://open.spotify.com/playlist/37i9dQZF1DX6xZZEgC9Ubl?si=JNhizU_yQcCj5M6CBmsxXw&utm_source=copy-link");
                            },
                            child: Row(
                              children: [
                                Image(
                                  height: 75.0,
                                  width: 75.0,
                                  image:
                                      AssetImage("assets/images/teardrop.jpg"),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Tear Drop',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'OpenSans-Condensed')),
                                SizedBox(
                                  height: 2.0,
                                  width: 12.0,
                                ),
                              ],
                            ),
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            )),
                      ],
                    )
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [
              0.3,
              1
            ],
            colors: [
              Color(0xffff4000),
              Color(0xffffcc66),
            ]),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Icon(Icons.chevron_right)
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [Color(0xff5f2c82), Color(0xff49a09d)]),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Data2",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold)),
              Text("Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Icon(Icons.chevron_right)
        ],
      ),
    );
  }
}
