import 'package:flutter/material.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  // Brand colors
  final Color primary;
  final Color secondary;
  final Color accent;

  // Surface colors
  final Color background;
  // forground
  final Color foreground;
  final Color surface;
  final Color card;

  // UI element colors
  final Color border;
  final Color divider;
  final Color icon;
  final Color disabled;
  final Color shadow;
  final Color overlay;
  final Color badge;

  // Text colors
  final Color textPrimary;
  final Color textSecondary;

  // Semantic colors
  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  const AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.foreground,
    required this.surface,
    required this.card,
    required this.border,
    required this.divider,
    required this.icon,
    required this.disabled,
    required this.shadow,
    required this.overlay,
    required this.badge,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
  });

  @override
  AppColorScheme copyWith({
    Color? primary,
    Color? secondary,
    Color? accent,
    Color? background,
    Color? foreground,
    Color? surface,
    Color? card,
    Color? border,
    Color? divider,
    Color? icon,
    Color? disabled,
    Color? shadow,
    Color? overlay,
    Color? badge,
    Color? textPrimary,
    Color? textSecondary,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      icon: icon ?? this.icon,
      disabled: disabled ?? this.disabled,
      shadow: shadow ?? this.shadow,
      overlay: overlay ?? this.overlay,
      badge: badge ?? this.badge,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      badge: Color.lerp(badge, other.badge, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
