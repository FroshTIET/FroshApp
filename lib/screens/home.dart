import 'package:flutter/material.dart';
import 'package:froshApp/state/themeNotifier.dart';
import 'package:froshApp/util/places.dart';
import 'package:froshApp/widgets/horizontal_place_item.dart';
import 'package:froshApp/widgets/icon_badge.dart';
import 'package:froshApp/widgets/search_bar.dart';
import 'package:froshApp/widgets/vertical_place_item.dart';
import 'package:froshApp/util/const.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';

class HomeWrapper extends StatefulWidget {
  ThemeData currentTheme = Constants.lightTheme;
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Provider.of<ThemeProvider>(context).theme,
      darkTheme: Constants.darkTheme,
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: Provider.of<ThemeProvider>(context).switchTheme,
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Where are you \ngoing?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(20.0),
          //   child: SearchBar(),
          // ),
          buildHorizontalList(context),
          buildVerticalList(),
        ],
      ),
    );
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0.0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return HorizontalPlaceItem(place: place);
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return VerticalPlaceItem(place: place);
        },
      ),
    );
  }
}
