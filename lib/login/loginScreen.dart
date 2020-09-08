import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/screens/home.dart';
import 'package:froshApp/theme/colorTheme.dart';
import 'package:flutter_login/flutter_login.dart';

Future<String> loginCheck() async {}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _recoverPassword(String name) async {
    return await "Password recovery is disallowed by the administrator";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'FROSH 2020',
      emailValidator: emailValidator,
      passwordValidator: passwordValidator,
      onLogin: (_data) => getAuthToken(_data),
      onSignup: (_data) => registerUser(_data),
      onSubmitAnimationCompleted: () async {
        await prefs.setString("userToken", userToken);
        await prefs.setBool("firstVisit", false);
        firstVisit = false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeWrapper(),
        ));
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

Future<String> getAuthToken(LoginData data) async {
  Dio dio = new Dio();
  try {
    Response response = await dio.post("$apiUrl/api-token-auth/",
        data: {"username": data.name, "password": data.password});
    userToken = response.data['token'];
    return null;
  } catch (e) {
    if (e is DioError) {
      DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          return "Request to the Frosh server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          return "Connection timeout with the Frosh server";
          break;
        case DioErrorType.DEFAULT:
          return "Please check your internet connection.";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          return "Receive timeout in connection with the Frosh server";
          break;
        case DioErrorType.RESPONSE:
          if (e.response.statusCode == 400) {
            return "Incorrect username and password.";
          } else {
            return "Received invalid status code: ${dioError.response.statusCode}";
          }

          break;
        case DioErrorType.SEND_TIMEOUT:
          return "Send timeout in connection with the Frosh server";
          break;
      }
    }
    return "An unkown error occured";
  }
}

Future<String> authUser(LoginData data) async {
  return Future.delayed(loginTime).then((_) async {
    if ((data.name == "frosh") && (data.password == "password")) {
      return null;
    } else {
      return "Incorrect username and password";
    }
  });
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
