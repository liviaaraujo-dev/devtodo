import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURL;
  final String email;
  final String id;

  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      this.photoURL});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        photoURL: map['photoURL'],
        email: map['email'],
        id: map['id']);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoURL": photoURL,
      };

  String toJson() => jsonEncode(toMap());
}
