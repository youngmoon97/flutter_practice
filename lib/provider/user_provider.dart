import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_prac/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> login(
    String username,
    String password, {
    bool rememberId = false,
    bool rememberMe = false,
  }) async {
    _loginStat = false; // 로그인 상태 초기화

    // const url = 'http://10.0.2.2:8080/login';
    const url = 'http://localhost:8080/login';
    final data = {'username': username, 'password': password};

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
        final jwt = authorizationHeader.replaceFirst('Bearer ', '');
        print('JWT : $jwt');
        await storage.write(key: 'jwt', value: jwt);
        // 사용자 정보 => Provider에 업데이트
        print("response.data : ${response.data}");
        _userInfo = User.fromMap(response.data);
        _loginStat = true;
        //  ######## 로그인 처리 ##########

        // 아이디 저장
        if (rememberId) {
          await storage.write(key: 'username', value: username);
        } else {
          await storage.delete(key: 'username');
        }
        // 자동 로그인
        if (rememberMe) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('auto_login', true);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('auto_login', false);
        }
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

  // 사용자 정보 요청
  Future<bool> getUserInfo() async {
    const url = 'http://localhost:8080/users/info';
    try {
      String? jwt = await storage.read(key: 'jwt');
      print('JWT : $jwt');
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authrization': 'Bearer $jwt',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        // 사용자 정보 업데이트
        final userInfo = response.data;
        if (userInfo == null) {
          print('사용자 정보가 없습니다.');
          return false;
        }
        _userInfo = User.fromMap(userInfo);
        notifyListeners();
        return true;
      } else {
        print('사용자 정보 요청 실패...');
        return false;
      }
    } catch (error) {
      print("사용자 정보 요청 중 에러 발생 $error");
      return false;
    }
  }

  // 자동 로그인 처리
  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('auto_login') ?? false;

    if (rememberMe) {
      final jwt = await storage.read(key: 'jwt');
      if (jwt != null) {
        // 사용자 정보 요청
        bool result = await getUserInfo();

        // 시용자 요청 정보 응답 성공 시, 로그인 여부 true로 설정
        if (result) {
          _loginStat = true;
          notifyListeners();
        }
      }
    }
  }

  Future<void> logout() async {
    try {
      // 로그아웃 처리
      // 1. jwt 토큰 삭제
      await storage.delete(key: 'jwt');
      // 2. 사용자 정보 삭제
      _userInfo = User();
      // 3. 로그인 상태 false로 변경
      _loginStat = false;
      // 4. 아이디저장, 자동 로그인 여부 false로 변경
      storage.delete(key: 'username');
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('auto_login');
      print("로그아웃 처리 완료...");
    } catch (error) {
      print("로그아웃 처리 중 에러 발생 $error");
    }
    notifyListeners();
  }
}
