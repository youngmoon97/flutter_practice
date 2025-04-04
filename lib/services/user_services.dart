import 'package:dio/dio.dart';

class UserServices {
  final Dio _dio = Dio(
    // BaseOptions(
    //   baseUrl: 'https://10.0.2.2:8080', // API URL
    //   connectTimeout: 5000, // 5 seconds
    //   receiveTimeout: 3000, // 3 seconds
    // ),
  );
  final String host = 'https://10.0.2.2:8080'; // API URL

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
