import 'package:flutter/material.dart';
import 'package:flutter_app_prac/notifications/snackbar.dart';
import 'package:flutter_app_prac/services/user_services.dart';
import 'package:flutter_app_prac/widgets/common_bottom_navigation_bar.dart';
import 'package:flutter_app_prac/widgets/custom_button.dart';
import 'package:flutter_app_prac/widgets/custom_drawer.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _username;
  String? _password;
  String? _confirmPassword;
  String? _name;
  String? _email;

  UserService userService = UserService();

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
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 100,
                ),
              ),
              TextFormField(
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
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    // borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  }
                  if (value.length < 6) {
                    return '비밀번호는 6자 이상이어야 합니다.';
                  }
                  return null; // 유효성 검사 통과
                },
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '비밀번호를 입력하세요.',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    // borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  }
                  if (value != _password) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null; // 유효성 검사 통과
                },
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  hintText: '비밀번호 확인를 입력하세요.',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    // borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _confirmPassword = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이름를 입력하세요.';
                  }
                  return null; // 유효성 검사 통과
                },
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '이름을 입력하세요.',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    // borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '이메일을 입력하세요.';
                  }
                  bool emailValid = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  ).hasMatch(value);
                  if (!emailValid) {
                    return '유효한 이메일을 입력해주세요.';
                  }
                  return null; // 유효성 검사 통과
                },
                decoration: InputDecoration(
                  labelText: '이메일',
                  hintText: '이메일를 입력하세요.',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(8),
                    // borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomSheet: CustomButton(
        text: "회원가입",
        inFullWidth: true,
        onPressed: () async {
          // 회원가입 요청
          if (!_formKey.currentState!.validate()) {
            return;
          }
          bool result = await userService.registerUser({
            'username': _username!,
            'password': _password!,
            'name': _name!,
            'email': _email!,
          });
          if (result) {
            print("회원가입 성공");
            Snackbar(
              text: '회원가입 성공하였습니다.',
              icon: Icons.check_circle,
              duration: 2,
              backgroundColor: Colors.greenAccent,
            ).shoSnackbar(context);
            Navigator.pop(context);
          } else {
            print("회원가입 실패");
            Snackbar(
              text: '회원가입 실패하였습니다.',
              icon: Icons.error,
              duration: 2,
              backgroundColor: Colors.redAccent,
            ).shoSnackbar(context);
          }
        },
      ),
    );
  }
}
