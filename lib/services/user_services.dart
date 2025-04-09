import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
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

  // 회원정보 조회
  Future<Map<String, dynamic>> getUser(String? username) async {
    if (username == null) {
      return {};
    }
    try {
      final storage = const FlutterSecureStorage();
      String? jwt = await storage.read(key: 'jwt');
      final response = await _dio.get(
        '$host/users/info',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("회원정보 조회");
        return response.data;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('회원 정보 조회 요청 시, 에러 발생: $e');
      return {};
    }
  }

  Future<bool> updateUser(Map<String, dynamic> userData) async {
    try {
      final storage = const FlutterSecureStorage();
      String? jwt = await storage.read(key: 'jwt');
      final response = await _dio.put(
        '$host/users',
        data: userData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        print("회원정보 수정 성공");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('회원정보 수정 실패: $e');
      return false;
    }
  }
}
