import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:froshApp/login/loginScreen.dart';
import 'package:froshApp/screens/home.dart';
import 'package:froshApp/state/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:froshApp/models/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  prefs = await SharedPreferences.getInstance();

  userToken = prefs.getString("userToken") ?? "";
  firstVisit = prefs.getBool("firstVisit") ?? true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
      child: MaterialApp(
        title: "Frosh 2K20",
        home: userToken == "" ? LoginScreen() : HomeWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
