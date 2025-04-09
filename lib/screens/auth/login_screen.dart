import 'package:flutter/material.dart';
import 'package:flutter_app_prac/notifications/snackbar.dart';
import 'package:flutter_app_prac/provider/user_provider.dart';
import 'package:flutter_app_prac/widgets/common_bottom_navigation_bar.dart';
import 'package:flutter_app_prac/widgets/custom_button.dart';
import 'package:flutter_app_prac/widgets/custom_drawer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false; // 비밀번호 노출 여부
  bool _rememberMe = false; // 자동 로그인
  bool _rememberId = false; // 아이디 저장

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // 저장소
  final storage = const FlutterSecureStorage();
  String? _username; // 아이디 저장소

  @override
  void initState() {
    super.initState();
    _loadUsername(); // 아이디 저장소에서 아이디 불러오기
  }

  void _loadUsername() async {
    _username = await storage.read(key: 'username');
    if (_username != null) {
      _usernameController.text = _username!;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider 선언
    // listen
    // -true : 변경 사항을 수신 대기⭕
    // -false : 변경 사항을 수신 대기❌
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
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
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 100,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력하세요.';
                  }
                  return null; // 유효성 검사 통과
                },
                decoration: InputDecoration(
                  labelText: '아이디',
                  hintText: '아이디를 입력하세요.',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  }
                  return null; // 유효성 검사 통과
                },
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '비밀번호를 입력하세요.',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_isPasswordVisible,
              ),
              // 자동 로그인, 아이디 저장 체크박스
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberMe = !_rememberMe;
                      });
                    },
                    child: Text('자동 로그인'),
                  ),
                  Checkbox(
                    value: _rememberId,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberId = value!;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rememberId = !_rememberId;
                      });
                    },
                    child: Text('아이디 저장'),
                  ),
                ],
              ),
              CustomButton(
                text: "로그인",
                onPressed: () async {
                  // 유효성 검사
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  // 로그인 요청
                  await userProvider.login(
                    username,
                    password,
                    rememberId: _rememberId,
                    rememberMe: _rememberMe,
                  );

                  if (userProvider.isLogin) {
                    print("로그인 성공");
                    Snackbar(
                      text: '로그인 성공했습니다.',
                      icon: Icons.check_circle,
                      duration: 2,
                      backgroundColor: Colors.green,
                    ).shoSnackbar(context);
                    // 로그인 성공
                    // 홈 화면으로 이동
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/');
                    return;
                  } else {
                    print("로그인 실패");
                    // 로그인 실패
                    Snackbar(
                      text: '로그인 실패했습니다.',
                      icon: Icons.error,
                      duration: 2,
                      backgroundColor: Colors.red,
                    ).shoSnackbar(context);
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: Text('아이디 찾기')),
                  TextButton(onPressed: () {}, child: Text('비밀번호 찾기')),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: "회원가입",
                onPressed: () {
                  Navigator.pushNamed(context, '/auth/join');
                },
                backgroundColor: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
