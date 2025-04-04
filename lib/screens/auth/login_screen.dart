import 'package:flutter/material.dart';
import 'package:flutter_app_prac/widgets/common_bottom_navigation_bar.dart';
import 'package:flutter_app_prac/widgets/custom_button.dart';
import 'package:flutter_app_prac/widgets/custom_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                validator: (value) {},
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
                validator: (value) {},
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
                onPressed: () {
                  // TODO : 로그인 처리
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
