import 'package:flutter/material.dart';
import 'package:froshApp/login/loginScreen.dart';
import 'package:froshApp/state/themeNotifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: MaterialApp(
        title: "My app",
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
