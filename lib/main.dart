import 'package:flutter/material.dart';
import 'package:masoi/screens/home_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MaSoiApp());
}

const version = 'v0.4';

class MaSoiApp extends StatelessWidget {
  const MaSoiApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma sói Fantasy',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
      // home: const MyHomePage(title: 'Web hỗ trợ dân làng Fantasy $version'),
    );
  }
}
