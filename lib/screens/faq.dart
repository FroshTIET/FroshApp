import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    var pixelheight = MediaQuery.of(context).size.height / 100;
    var pixelwidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        body: Center(
      child: Text("TODO......."),
    ));
  }
}
