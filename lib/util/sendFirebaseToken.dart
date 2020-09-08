import 'package:dio/dio.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/models/student.dart';

Future<Student> sendFirebaseToken(
    String usertoken, String firebaseToken) async {
  Dio dio = new Dio();
  dio.options.headers["Authorization"] = "Token $usertoken";
  try {
    Response response = await dio
        .post("$apiUrl/api/pushToken/", data: {"token": firebaseToken});
    print("Sending firebase token: ${response.data}");
    return null;
  } catch (e) {
    print(e);
  }
  return null;
}
