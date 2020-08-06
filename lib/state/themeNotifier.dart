import 'package:flutter/material.dart';
import 'package:froshApp/util/const.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData theme = Constants.lightTheme;

  void switchTheme() {
    if (theme == Constants.lightTheme) {
      theme = Constants.darkTheme;
    } else {
      theme = Constants.lightTheme;
    }
    notifyListeners();
  }
}
