import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:thegoodplace/loaders/creating.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  Future<void> sendMail(bool loading) async {
    String username = 'aayanagarwal05@gmail.com';
    String password = "#####";
    // Enter your own password here
    final user = _auth.currentUser;
    setState(() {
      loading = true;
    });
    final smtpServer = gmail(username, password);
    final contacts = await _database.collection('users').doc(user.uid).get();
    for (var contact in contacts['contacts']) {
      final message = Message()
        ..from = Address("aayanagarwal05@gmail.com")
        ..recipients.add(contact)
        ..subject = 'Emotional alert for ${user.displayName}'
        ..text =
            '${user.displayName} has listed you as their emergency contact in mental health related issues. They have alerted an SOS. Contact them immediately!';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
        Fluttertoast.showToast(msg: 'Sent an SOS!');
        setState(() {
          loading = false;
        });
      } on MailerException catch (e) {
        print('Message not sent.');
        print(e.toString());
        setState(() {
          loading = false;
        });
        return 'Some Error Occured';
      }
    }
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
                    "How're you feeling today?",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.sentiment_very_satisfied,
                            color: Colors.green[400]),
                        onPressed: () {
                          Navigator.pushNamed(context, '/happy');
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            )),
                        label: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: GradientText(
                            text: 'Happy',
                            colors: <Color>[
                              HexColor('#8BC6EC'),
                              HexColor('#9599E2')
                            ],
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        width: 5.0,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/angry');
                        },
                        icon: Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent[200],
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            )),
                        label: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: GradientText(
                            text: 'Angry',
                            colors: <Color>[
                              HexColor('#8BC6EC'),
                              HexColor('#9599E2')
                            ],
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sad');
                    },
                    icon: Icon(Icons.sentiment_very_dissatisfied,
                        color: Colors.blue[600]),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        )),
                    label: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GradientText(
                        text: 'Sad',
                        colors: <Color>[
                          HexColor('#8BC6EC'),
                          HexColor('#9599E2')
                        ],
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        icon: Icon(Icons.exit_to_app),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            )),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                        label: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: GradientText(
                            text: "Sign Out",
                            colors: <Color>[
                              HexColor('#8BC6EC'),
                              HexColor('#9599E2')
                            ],
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.alarm),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            )),
                        onPressed: () async {
                          sendMail(loading);
                        },
                        label: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: GradientText(
                            text: "SOS",
                            colors: <Color>[
                              HexColor('#8BC6EC'),
                              HexColor('#9599E2')
                            ],
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
