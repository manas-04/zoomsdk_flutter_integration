import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zoom_sdk_integration/join_screen.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Zoom SDK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JoinWidget(),
    );
  }
}
