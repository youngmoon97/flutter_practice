class Auth {
  int? authNo;
  String? userId;
  String? auth;

  Auth({this.authNo, this.userId, this.auth});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      authNo: json['authNo'],
      userId: json['userId'],
      auth: json['auth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'authNo': authNo, 'userId': userId, 'auth': auth};
  }
}
