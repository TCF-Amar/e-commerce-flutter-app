import 'package:flutter_e_commerce/features/auth/domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel({
    required super.name,
    required super.email,
    required super.password,
    super.avatar,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    name: json['name'],
    email: json['email'],
    password: json['password'],
    avatar: json['avatar'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'avatar': avatar,
  };
}
