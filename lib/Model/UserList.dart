class UserList {
  final int? id;
  final String? last_name;
  final String? email;
  final String? first_name;
  final String? avatar;

  UserList({this.id, this.first_name, this.last_name, this.email, this.avatar});

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      id: json['id'] as int,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
    );
  }
}