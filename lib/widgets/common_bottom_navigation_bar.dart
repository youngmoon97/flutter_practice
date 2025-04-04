import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CommonBottomNavigationBar({Key? key, required this.currentIndex})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/user/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/user/product');
            break;
          case 3:
            Navigator.pushNamed(context, '/user/cart');
            break;
          case 4:
            Navigator.pushNamed(context, '/mypage/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: '상품'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '장바구니'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
      ],
    );
  }
}
// import 'package:flutter/material.dart';

// class CommonBottomNavigationBar extends StatefulWidget {
//   final int currentIndex;

//   const CommonBottomNavigationBar({super.key, required this.currentIndex});

//   @override
//   State<CommonBottomNavigationBar> createState() =>
//       _CommonBottomNavigationBarState();
// }

// class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
//   late int currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.currentIndex; // 초기값 설정
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       // selectedItemColor: Theme.of(context).colorScheme.primary,
//       selectedItemColor: Colors.red,
//       unselectedItemColor: Colors.grey,
//       currentIndex: currentIndex,
//       onTap: (index) {
//         setState(() {
//           currentIndex = index;
//         });
//       },
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
//         BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
//         BottomNavigationBarItem(icon: Icon(Icons.category), label: '상품'),
//         BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '장바구니'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이'),
//       ],
//     );
//   }
// }
