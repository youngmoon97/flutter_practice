import 'package:flutter/material.dart';
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

  UserServices userServices = UserServices();

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
                validator: (value) {},
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
                validator: (value) {},
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
                validator: (value) {},
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
                validator: (value) {},
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
                validator: (value) {},
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
          if (_password != _confirmPassword) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('비밀번호가 일치하지 않습니다.')));
            return;
          }
          bool result = await userServices.registerUser({
            'username': _username!,
            'password': _password!,
            'name': _name!,
            'email': _email!,
          });
          if (result) {
            print("회원가입 성공");
            Navigator.pop(context);
          } else {
            print("회원가입 실패");
          }
        },
      ),
    );
  }
}
