import 'package:flutter/material.dart';

import '../../constants/global.dart';
import '../../gen/fonts.gen.dart';
import 'app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  static final appTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    canvasColor: AppColors.white,
    fontFamily: FontFamily.outfit,
    appBarTheme: const AppBarTheme(scrolledUnderElevation: 0, color: AppColors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.transparent),
          borderRadius: BorderRadius.circular(24),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.outfit,
        ),
        shadowColor: AppColors.transparent,
        elevation: 0,
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
        foregroundColor: AppColors.white,
        disabledForegroundColor: AppColors.neutral9.withValues(alpha: 0.4),
        iconColor: AppColors.neutral9,
        disabledIconColor: AppColors.neutral9.withValues(alpha: 0.4),
        minimumSize: const Size(double.infinity, Global.kButtonHeight),
      ),
    ),
    iconTheme: const IconThemeData(size: 20, color: AppColors.icon),

    /// text field theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsetsDirectional.only(
        start: 12,
        end: 12,
        top: 16,
        bottom: 16,
      ),
      labelStyle: TextStyles.body1Regular.copyWith(color: AppColors.neutral4),
      floatingLabelStyle: TextStyles.caption1Regular.copyWith(
        color: AppColors.stroke,
      ),
      errorStyle: TextStyles.caption1Regular.copyWith(color: AppColors.red),
      enabledBorder: _getFieldInputBorder(borderColor: AppColors.stroke),
      focusedBorder: _getFieldInputBorder(borderColor: AppColors.neutral9),
      errorBorder: _getFieldInputBorder(borderColor: AppColors.red),
      focusedErrorBorder: _getFieldInputBorder(borderColor: AppColors.red),
      disabledBorder: _getFieldInputBorder(borderColor: AppColors.stroke),
    ),
  );

  // -----  -----
  static InputBorder _getFieldInputBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(24),
    );
  }
}
