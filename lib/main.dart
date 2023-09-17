import 'package:flutter/material.dart';
import 'package:youtube_app/views/screens/homepage.dart';
import 'package:youtube_app/views/screens/openpage.dart';
import 'package:youtube_app/views/screens/searchpage.dart';

void main(){
  runApp(MyApp(),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>HomePage(),
        'openPage':(context)=>PlayerPage(),
        'searchPage':(context)=>SearchPage(),
      },
    );
  }
}
