import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String name;
  final String email;
  final String password;
  final String? avatar;

  const Register({
    required this.name,
    required this.email,
    required this.password,
    this.avatar = 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
  });

  @override
  List<Object?> get props => [name, email, password, avatar];
}
