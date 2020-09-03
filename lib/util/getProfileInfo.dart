import 'package:dio/dio.dart';
import 'package:froshApp/models/constants.dart';
import 'package:froshApp/models/student.dart';

Future<Student> getProfileDetails(String token) async {
  Dio dio = new Dio();
  dio.options.headers["Authorization"] = "Token $token";
  try {
    Response response = await dio.get("$apiUrl/api/student/detail/");
    // throw(Student.fromJson(response.data).toJson());
    return Student.fromJson(response.data);
  } catch (e) {
    if (e is DioError) {
      DioError dioError = e;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          return Future.error("Request to the Frosh server was cancelled");
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          return Future.error("Connection timeout with the Frosh server");
          break;
        case DioErrorType.DEFAULT:
          return Future.error("Please check your internet connection.");
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          return Future.error(
              "Receive timeout in connection with the Frosh server");
          break;
        case DioErrorType.RESPONSE:
          if (e.response.statusCode == 400) {
            return Future.error(
                "Incorrect authentication token. Please login again.");
          } else {
            return Future.error(
                "Received invalid status code: ${dioError.response.statusCode}");
          }

          break;
        case DioErrorType.SEND_TIMEOUT:
          return Future.error(
              "Send timeout in connection with the Frosh server");
          break;
      }
    }
    return Future.error("An unkown error occured");
  }
  return null;
}
