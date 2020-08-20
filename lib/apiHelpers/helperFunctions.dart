import 'package:dio/dio.dart';

Future<Map<String, dynamic>> getStudentDetails(String token) async {
  var dio = Dio();
  dio.options.headers['Authorization'] = 'Token $token';
  try {
    var response = await dio.get('https://frosh.magnum.wtf/student/detail/');
    return Map.from({'data': response.data, 'errors': null});
  } on DioError catch (e) {
    if (e.response.statusCode == 400) {
      return Map.from({'errors': 'Bad request'});
    } else {
      return Map.from({'errors': 'Server error ${e.response.statusCode}.'});
    }
  }
}

Future<Map<String, String>> getAuthToken(
    String username, String password) async {
  var dio = Dio();

  try {
    var response = await dio.post('https://frosh.magnum.wtf/api-token-auth/',
        data: {'username': username, 'password': password});
    return Map.from({'token': response.data['token'], 'errors': null});
  } on DioError catch (e) {
    if (e.response.statusCode == 400) {
      return Map.from({'errors': 'Wrong username or password'});
    } else {
      return Map.from({'errors': 'Server error ${e.response.statusCode}.'});
    }
  }
}
