import 'package:flutter/material.dart';

import 'package:timer/screens/home/home.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,

      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}

