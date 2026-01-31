import 'package:flutter_e_commerce/features/auth/domain/entities/user.dart';

class UserModel extends UserProfileEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.role,
    super.avatar,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatar: json['avatar'] as String?,
      createdAt:
          json['creationAt'] as String, // API uses 'creationAt' not 'createdAt'
      updatedAt: json['updatedAt'] as String,
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      id: id,
      email: email,
      name: name,
      role: role,
      avatar: avatar,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'avatar': avatar,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
