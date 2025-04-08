import 'package:flutter/material.dart';
import 'package:flutter_app_prac/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );

    return Drawer(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: SizedBox.shrink(),
            ),
            _DrawerItem(
              icon: Icons.home,
              text: '홈',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(
                  context,
                  '/',
                ); // Navigate to home screen
              },
            ),
            _DrawerItem(
              icon: Icons.person,
              text: '마이',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/mypage/profile');
              },
            ),
            _DrawerItem(
              icon: Icons.category,
              text: '검색',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/user/search');
              },
            ),
            _DrawerItem(
              icon: Icons.category,
              text: '상품',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/user/product');
              },
            ),
            _DrawerItem(
              icon: Icons.shopping_bag,
              text: '장바구니',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacementNamed(context, '/user/cart');
              },
            ),
          ],
        ),
        bottomSheet: Container(
          color: Colors.blue,
          child:
              userProvider != null && userProvider.isLogin
                  ?
                  //  로그아웃
                  _DrawerItem(
                    icon: Icons.logout,
                    text: '로그아웃',
                    onTap: () {},
                    color: Colors.white,
                  )
                  :
                  // 로그인 / 회원가입
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the drawer
                            Navigator.pushNamed(
                              context,
                              '/auth/login',
                            ); // Navigate to login screen
                          },
                          child: Text(
                            '로그인',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the drawer
                            Navigator.pushNamed(
                              context,
                              '/auth/join',
                            ); // Navigate to join screen
                          },
                          child: Text(
                            '회원가입',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}

// DrawerItem
Widget _DrawerItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
  Color? color,
  MaterialColor? backgroundColor,
}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text),
    tileColor: backgroundColor,
    textColor: color,
    onTap: onTap,
  );
}
