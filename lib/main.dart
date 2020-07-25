import 'package:flutter/material.dart';
import 'package:shareme/screens/task.dart';
import './screens/share.dart';
import './screens/contacts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:NewClient(),
      routes: {
        Contacts.rout:(ctx)=>Contacts(),
        Share.rout:(ctx)=>Share()
      },
    );
  }
}
