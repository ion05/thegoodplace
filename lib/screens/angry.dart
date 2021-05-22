import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AngryPage extends StatefulWidget {
  @override
  _AngryPageState createState() => _AngryPageState();
}

class _AngryPageState extends State<AngryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [HexColor('#8BC6EC'), HexColor('#9599E2')],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Here's what you can do!",style: TextStyle(fontSize: 36.0, fontWeight:FontWeight.w700, color: Colors.white, fontFamily: "Nunito-Sans",),
              SizedBox(
                height: 30.0,
              ),
              TextField(
                decoration: InputDecoration(
                    //hintText('Why are you angry?'),
                    ),
              ),
              SizedBox(height: 50.0),
              Row(
                children: [
                  SizedBox(
                    width: 50.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Submit'),
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Scream Zone'),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                  'Do check our Spotify playlist that might create that vibe for you'),
            ],
          ),
        ),
      ),
    );
  }
}
