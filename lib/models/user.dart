import 'package:flutter_app_prac/models/auth.dart';

class User {
  int? no;
  String? userId;
  String? userPw;
  String? userPwCheck;
  String? name;
  String? email;
  DateTime? regDate;
  DateTime? updDate;
  int? enabled;
  List<Auth>? authList;

  User({
    this.no,
    this.userId,
    this.userPw,
    this.userPwCheck,
    this.name,
    this.email,
    this.regDate,
    this.updDate,
    this.enabled,
    this.authList,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      no: json['no'],
      userId: json['userId'],
      userPw: json['userPw'],
      userPwCheck: json['userPwCheck'],
      name: json['name'],
      email: json['email'],
      regDate: json['regDate'] != null ? DateTime.parse(json['regDate']) : null,
      updDate: json['updDate'] != null ? DateTime.parse(json['updDate']) : null,
      enabled: json['enabled'],
      authList:
          (json['authList'] as List<dynamic>)
              .map((authJson) => Auth.fromJson(authJson))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'userId': userId,
      'userPw': userPw,
      'userPwCheck': userPwCheck,
      'name': name,
      'email': email,
      'regDate': regDate?.toIso8601String(),
      'updDate': updDate?.toIso8601String(),
      'enabled': enabled,
      'authList': authList?.map((auth) => auth.toJson()).toList(),
    };
  }
}
