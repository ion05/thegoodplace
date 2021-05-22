import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thegoodplace/loaders/creating.dart';
import 'package:thegoodplace/screens/angry.dart';
import 'package:thegoodplace/screens/happy.dart';
import 'package:thegoodplace/screens/home.dart';
import 'package:thegoodplace/screens/sad.dart';
import 'package:thegoodplace/wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Unable to Initialize App');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'The Good Place',
            routes: {
              '/question': (context) => HomeScreen(),
              '/happy': (context) => HappyPage(),
              '/sad': (context) => SadPage(),
              '/angry': (context) => AngryPage()
            },
            home: Wrapper(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
