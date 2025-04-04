import 'package:flutter/material.dart';
import 'package:flutter_app_prac/widgets/common_bottom_navigation_bar.dart';
import 'package:flutter_app_prac/widgets/custom_button.dart';
import 'package:flutter_app_prac/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('홈'),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/second');
            //   },
            //   child: const Text('Go to Second Screen'),
            // ),
            // CustomButton(
            //   text: "로그인",
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/second');
            //   },
            //   inFullWidth: true,
            //   color: Colors.white,
            //   backgroundColor: Colors.blue,
            // ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 0),
    );
  }
}
