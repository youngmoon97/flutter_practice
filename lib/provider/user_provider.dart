import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_prac/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider extends ChangeNotifier {
  // 로그인 정보
  late User _userInfo;
  // 로그인 상태
  bool _loginStat = false;

  // getter
  // get : getter 메소드를 정의하는 키워드
  User get userInfo => _userInfo; // 전역변수
  bool get isLogin => _loginStat; // 전역변수
  // setter
  set userInfo(User user) {
    _userInfo = user; // 전역변수
  }

  set loginstat(bool loginStat) {
    _loginStat = loginStat; // 전역변수
  }

  //http 요청 객체
  final Dio _dio = Dio();
  // 🔒 안전한 저장소
  final storage = const FlutterSecureStorage();

  /// 🔐 로그인 요청
  /// 1. 요청 및 응답
  /// ➡ username, password
  /// ⬅ jwt token
  ///
  /// 2. jwt 토큰을 SecureStorage 에 저장
  Future<void> login(String username, String password) async {
    _loginStat = false; // 로그인 상태 초기화

    // const url = 'http://10.0.2.2:8080/login';
    const url = 'http://localhost:8080/login';
    final data = {"username": username, "password": password};

    try {
      // 로그인 요청
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        // JWT -> SecureStorage 저장
        final authorizationHeader = response.headers['authorization']?.first;

        if (authorizationHeader == null) {
          print("로그인 정보가 없습니다.");
          return;
        }

        print('로그인 성공...');
        // Authorization 헤더에서 "Bearer "를 제거하고 JWT 토큰 값을 추출
        final jwt = authorizationHeader.replaceFirst('Bearer ', '');
        print('JWT : $jwt');
        await storage.write(key: 'jwt', value: jwt);

        // 사용자 정보 => Provider에 업데이트
        _userInfo = User.fromJson(json.decode(response.data));
        _loginStat = true;
      } else if (response.statusCode == 403) {
        print('아이디 또는 비밀번호가 일치하지 않습니다...');
      } else {
        print('네트워크 오류 또는 알 수 없는 오류로 로그인에 실패하였습니다...');
      }
    } catch (error) {
      print("로그인 처리 중 에러 발생 $error");
      return;
    }
    // 공유된 상태를 가진 위젯 다시 빌드
    notifyListeners();
  }
}
