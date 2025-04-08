import 'package:dio/dio.dart';

class UserServices {
  final Dio _dio = Dio();
  // final String host = 'http://10.0.2.2:8080'; // API URL
  final String host = 'http://localhost:8080'; // API URL

  Future<bool> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post('$host/users', data: userData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
