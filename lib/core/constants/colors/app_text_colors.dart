import 'package:flutter/material.dart';

@immutable
class AppTextColors extends ThemeExtension<AppTextColors> {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color warning;
  final Color error;
  final Color link;

  const AppTextColors({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.link,
  });

  @override
  AppTextColors copyWith({
    Color? primary,
    Color? secondary,
    Color? success,
    Color? warning,
    Color? error,
    Color? link,
  }) {
    return AppTextColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      link: link ?? this.link,
    );
  }

  @override
  AppTextColors lerp(ThemeExtension<AppTextColors>? other, double t) {
    if (other is! AppTextColors) return this;
    return AppTextColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      link: Color.lerp(link, other.link, t)!,
    );
  }
}
