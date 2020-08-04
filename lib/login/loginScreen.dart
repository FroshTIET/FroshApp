import 'package:flutter/material.dart';
import 'package:froshApp/theme/colorTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';
import 'dart:io';

Future<String> loginCheck() async {}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _recoverPassword(String name) async {
    return await "Password recovery is disallowed by the administrator";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'FROSH 2K20',
      emailValidator: emailValidator,
      passwordValidator: passwordValidator,
      onLogin: (_data) => authUser(_data),
      onSignup: (_data) => registerUser(_data),
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => Navbar(),
        // ));
        print("Logged in");
      },
      onRecoverPassword: (_) => recoverPassword(_),
      theme: LoginTheme(
        primaryColor: ColorClass.slightGrey,
        accentColor: ColorClass.slightGrey.withAlpha(200),
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: ColorClass.whiteBack,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: ColorClass.pureBlack,
          // shadows: [Shadow(color: ColorClass.darkYellow, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: ColorClass.whiteBack,
        ),
        cardTheme: CardTheme(
          color: ColorClass.whiteBack,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
      ),
      messages: LoginMessages(
        usernameHint: "Username",
        passwordHint: "Password",
        confirmPasswordHint: "Confirm Password",
        loginButton: "LOG IN",
        signupButton: "REGISTER",
        forgotPasswordButton: "Forgot Password ?",
        recoverPasswordButton: "Send Recovery Email",
      ),
    );
  }
}

Duration get loginTime => Duration(milliseconds: 2250);

Future<String> authUser(LoginData data) async {
  if ((data.name == "frosh") && (data.password == "password")) {
    return null;
  } else {
    return "Incorrect username and password";
  }
}

Future<String> registerUser(LoginData data) {
  return Future.delayed(loginTime).then((_) async {
    return "Registration is temporarily disabled. Please login using your provided credentials.";
  });
}

Future<String> recoverPassword(var data) {
  return Future.delayed(loginTime).then((_) async {
    return "Automated Password recovery is temporarily disabled. Please contact administrator";
  });
}

FormFieldValidator<String> emailValidator = (value) {
  if (value.isEmpty) {
    return 'Invalid username!';
  }
  return null;
};

FormFieldValidator<String> passwordValidator = (value) {
  if (value.isEmpty || value.length <= 2) {
    return 'Password is too short!';
  }
  return null;
};
