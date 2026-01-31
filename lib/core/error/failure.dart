

import 'package:flutter_e_commerce/core/error/failure_type.dart';

class Failure {
  final String message;
  final int? statusCode;
  final FailureType type;
  Failure({required this.message, this.statusCode, required this.type});
}
