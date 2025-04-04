import 'package:flutter/material.dart';
import 'package:flutter_app_prac/screens/auth/join_screen.dart';
import 'package:flutter_app_prac/screens/auth/login_screen.dart';
import 'package:flutter_app_prac/screens/home_screen.dart';
import 'package:flutter_app_prac/screens/mypage/profile_screen.dart';
import 'package:flutter_app_prac/screens/user/cart_screen.dart';
import 'package:flutter_app_prac/screens/user/product_screen.dart';
import 'package:flutter_app_prac/screens/user/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: const SearchScreen(),
      initialRoute: '/',
      // routes: {
      //   '/': (context) => HomeScreen(),
      //   '/auth/join': (context) => JoinScreen(),
      //   '/auth/login': (context) => LoginScreen(),
      //   '/user/search': (context) => SearchScreen(),
      //   '/user/product': (context) => ProductScreen(),
      //   '/user/cart': (context) => CartScreen(),
      //   '/mypage/profile': (context) => ProfileScreen(),
      // },
      onGenerateRoute: (setting) {
        // setting.name : 라우팅 경로( '/', '/auth/join', 등)
        switch (setting.name) {
          // 홈
          case '/':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => HomeScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 회원가입
          case '/auth/join':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => JoinScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 로그인
          case '/auth/login':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => LoginScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          //검색
          case '/user/search':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => SearchScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 상품
          case '/user/product':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => ProductScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 장바구니
          case '/user/cart':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => CartScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          // 마이페이지
          case '/mypage/profile':
            return PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) => ProfileScreen(),
              transitionDuration: Duration(seconds: 0),
            );
          default:
            return null;
        }
      },
    );
  }
}
