import 'package:flutter/material.dart';
import 'package:froshApp/login/loginScreen.dart';
import 'package:froshApp/theme/colorTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My app",
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.redAccent,
        primaryColor: ColorClass.darkYellow,
        brightness: Brightness.light,
      ),
    );
  }
}
