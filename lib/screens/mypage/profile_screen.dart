import 'package:flutter/material.dart';
import 'package:flutter_app_prac/models/user.dart';
import 'package:flutter_app_prac/notifications/snackbar.dart';
import 'package:flutter_app_prac/provider/user_provider.dart';
import 'package:flutter_app_prac/screens/home_screen.dart';
import 'package:flutter_app_prac/services/user_services.dart';
import 'package:flutter_app_prac/widgets/common_bottom_navigation_bar.dart';
import 'package:flutter_app_prac/widgets/custom_button.dart';
import 'package:flutter_app_prac/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  User? _user;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
  }

  String? _username;
  String? _name;
  String? _email;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );

    //로그인 상태 확인
    // - 로그인 안되어있으면
    if (!userProvider.isLogin) {
      // 로그인 화면으로 리다이렉트
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 남아있는 스택이 있는지 확인3
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushNamed(context, '/auth/login');
      });
      return const HomeScreen();
    }

    // 로그인 상태
    String? _username = userProvider.userInfo.username ?? '없음';
    String? _name = userProvider.userInfo.name ?? '없음';
    String? _email = userProvider.userInfo.email ?? '없음';

    if (_user == null) {
      userService.getUser(_username).then((value) {
        print('value :  $value');
        setState(() {
          _user = User.fromMap(value);
        });
      });
      // 텍스트폼 필드에 출력
      _usernameController.text = _user?.username ?? _username;
      _nameController.text = _user?.name ?? _name;
      _emailController.text = _user?.email ?? _email;
    }

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "프로필 수정",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                validator: (value) {},
                decoration: InputDecoration(
                  labelText: '아이디',
                  hintText: '아이디를 입력하세요.',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                validator: (value) {},
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '이름을 입력하세요.',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                validator: (value) {},
                decoration: InputDecoration(
                  labelText: '이메일',
                  hintText: '이메일을 입력하세요.',
                  prefixIcon: Icon(Icons.mail_outline),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "회원탈퇴",
                inFullWidth: true,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("회원 탈퇴"),
                        content: Text("정말로 탈퇴하시겠습니까?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("취소"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text("확인"),
                            onPressed: () {
                              Navigator.pop(context);
                              userService.deleteUser(_username).then((value) {
                                if (value) {
                                  // 회원 탈퇴 성공
                                  // - 로그아웃 처리
                                  userProvider.logout();
                                  // - 홈 화면으로 이동
                                  Navigator.pushReplacementNamed(context, '/');
                                }
                              });
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                backgroundColor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: CustomButton(
        text: "회원 정보 수정",
        inFullWidth: true,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Perform the update action
            bool result = await userService.updateUser({
              'username': _username,
              'name': _user!.name,
              'email': _user!.email,
            });
            if (result) {
              Snackbar(
                text: "회원정보 수정 성공",
                icon: Icons.check_circle,
                backgroundColor: Colors.green,
              ).shoSnackbar(context);
              userProvider.userInfo = User(
                username: _username,
                name: _user!.name,
                email: _user!.email,
              );
            }
            Navigator.pop(context);
          }
        },
      ),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 4),
    );
  }
}
