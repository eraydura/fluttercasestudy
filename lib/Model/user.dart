class User {
  final int? id;
  final String? token;

  User({this.id, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      token: json['token'] as String,
    );
  }
}