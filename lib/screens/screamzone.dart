import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

class ScreamZone extends StatefulWidget {
  @override
  _ScreamZoneState createState() => _ScreamZoneState();
}

class _ScreamZoneState extends State<ScreamZone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scream Zone'),
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Shout Zone',
                    hintText:
                        'You can rant here, shout your feeling, abuse and it will remain absolutely confidential',
                    focusColor: Colors.greenAccent[200],
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28.0)),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(28.0)),
                    labelStyle: TextStyle(
                        fontFamily: 'Roboto-Condensed',
                        fontSize: 18.0,
                        color: Colors.black),
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
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  ],
                ),
              ],
            )));
  }
}
