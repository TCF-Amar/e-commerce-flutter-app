import 'package:flutter/material.dart';

import 'package:flutter_e_commerce/core/constants/colors/app_color_scheme.dart';
import 'package:flutter_e_commerce/core/constants/colors/app_colors.dart';
import 'package:flutter_e_commerce/core/constants/colors/app_size.dart';
import 'package:flutter_e_commerce/core/constants/colors/app_text_colors.dart';

/// Extension to easily access AppColorScheme from BuildContext
extension ThemeExtensions on BuildContext {
  /// Access the app's color scheme
  AppColorScheme get colorScheme {
    return Theme.of(this).extension<AppColorScheme>()!;
  }

  AppColors get colors {
    return Theme.of(this).extension<AppColors>()!;
  }

  AppSizes get sizes {
    return Theme.of(this).extension<AppSizes>()!;
  }

  AppTextColors get textColors {
    return Theme.of(this).extension<AppTextColors>()!;
  }
}
