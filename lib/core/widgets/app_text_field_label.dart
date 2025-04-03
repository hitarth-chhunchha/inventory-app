import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';
import 'app_text_field.dart';

class AppTextFieldHeader extends StatelessWidget {
  final String headerTxt;
  final TextStyle? headerTxtStyle;
  final TextFieldType textFieldType;

  const AppTextFieldHeader({
    super.key,
    required this.headerTxt,
    this.headerTxtStyle,
    this.textFieldType = TextFieldType.normal,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: headerTxt,
        style: (headerTxtStyle ?? TextStyles.body2Medium).copyWith(
          color: AppColors.inputHeading,
        ),
        children: [
          switch (textFieldType) {
            TextFieldType.normal => const TextSpan(text: ''),
            TextFieldType.optional => TextSpan(
              text: ' (${AppStrings.optional})',
              style: (headerTxtStyle ?? TextStyles.body2Medium).copyWith(
                color: AppColors.neutral4,
              ),
            ),
            TextFieldType.required => TextSpan(
              text: '*',
              style: (headerTxtStyle ?? TextStyles.body2Medium).copyWith(
                color: AppColors.red,
              ),
            ),
          },
        ],
      ),
    );
  }
}
