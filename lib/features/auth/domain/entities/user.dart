import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? avatar;
  final String createdAt;
  final String updatedAt;

  const UserProfileEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, email, name, role, avatar, createdAt, updatedAt];
}
