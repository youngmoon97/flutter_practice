import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // state
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Screen!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
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
                onTap: () {},
                color: Colors.white,
                backgroundColor: Colors.blue,
              ),
              _DrawerItem(icon: Icons.person, text: '마이', onTap: () {}),
              _DrawerItem(icon: Icons.category, text: '상품', onTap: () {}),
              _DrawerItem(icon: Icons.shopping_bag, text: '장바구니', onTap: () {}),
            ],
          ),
          bottomSheet: Container(
            color: Colors.yellow,
            child:
            //  로그아웃
            _DrawerItem(
              icon: Icons.logout,
              text: '로그아웃',
              onTap: () {},
              color: Colors.white,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {},
            //         child: Text('로그인', style: TextStyle(color: Colors.white)),
            //       ),
            //     ),
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () {},
            //         child: Text('회원가입', style: TextStyle(color: Colors.white)),
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: '상품'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '장바구니',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
        ],
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
