import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreatingLoader extends StatefulWidget {
  @override
  _CreatingLoaderState createState() => _CreatingLoaderState();
}

class _CreatingLoaderState extends State<CreatingLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitChasingDots(color: Colors.black),
    );
  }
}
