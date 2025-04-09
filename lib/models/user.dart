import 'package:flutter_app_prac/models/auth.dart';

class User {
  int? no;
  String? id;
  String? username;
  String? password;
  String? name;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? enabled;
  List<Auth>? authList;

  User({
    this.no,
    this.id,
    this.username,
    this.password,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.enabled,
    this.authList,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      no: map['no'],
      id: map['id'].toString(),
      username: map['username'],
      password: map['password'],
      name: map['name'],
      email: map['email'],
      createdAt:
          map['createdAt'] != null
              ? DateTime.fromMicrosecondsSinceEpoch(map['createdAt'])
              : null,
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMicrosecondsSinceEpoch(map['updatedAt'])
              : null,
      enabled: map['enabled'],
      authList:
          map['authList'] != null
              ? List<Auth>.from(
                map['authList'].map((auth) => Auth.fromMap(auth)),
              )
              : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'enabled': enabled,
    };
  }
}
