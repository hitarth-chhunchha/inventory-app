import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes/navigation_methods.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';
import '../widgets/app_button.dart';
import 'animation_util/custom_slide_animation.dart';

class DialogUtils {
  /// Generic app dialog
  static void showAppDialog({
    required BuildContext context,
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
    String? titleImgPath,
    String title = "",
    String description = "",
    Widget? customWidget,
    String positiveText = "",
    String negativeText = "",
    bool barrierDismissible = false,
    bool backgroundBlur = true,
    Color positiveBtnColor = AppColors.primary,
    Color positiveTextColor = AppColors.white,
    Color negativeBtnColor = AppColors.iconBg,
    Color negativeTextColor = AppColors.neutral8,
    bool closeDialogOnBtnClick = true,
  }) {
    showDialog(
      context: context,
      builder:
          (builderContext) => _AppDialog(
            titleImgPath: titleImgPath,
            title: title,
            description: description,
            customWidget: customWidget,
            positiveText: positiveText,
            onPositiveTap: onPositiveTap,
            negativeText: negativeText,
            onNegativeTap: onNegativeTap,
            backgroundBlur: backgroundBlur,
            isDismissible: barrierDismissible,
            positiveBtnColor: positiveBtnColor,
            positiveTextColor: positiveTextColor,
            negativeBtnColor: negativeBtnColor,
            negativeTextColor: negativeTextColor,
            closeDialogOnBtnClick: closeDialogOnBtnClick,
          ),
    );
  }
}

/// Generic App Dialog View
class _AppDialog extends StatelessWidget {
  final String positiveText, negativeText, title, description;
  final Widget? customWidget;
  final String? titleImgPath;
  final VoidCallback? onPositiveTap, onNegativeTap;
  final bool isDismissible, backgroundBlur;
  final Color positiveBtnColor;
  final Color positiveTextColor;
  final Color negativeBtnColor;
  final Color negativeTextColor;
  final bool closeDialogOnBtnClick;

  const _AppDialog({
    this.titleImgPath,
    this.title = "",
    this.positiveText = "",
    this.negativeText = "",
    required this.description,
    this.customWidget,
    this.onPositiveTap,
    this.onNegativeTap,
    required this.isDismissible,
    required this.backgroundBlur,
    required this.positiveBtnColor,
    required this.positiveTextColor,
    required this.negativeBtnColor,
    required this.negativeTextColor,
    required this.closeDialogOnBtnClick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSlideTransition(
      animationType: AnimationType.bottomToTop,
      child: PopScope(
        canPop: isDismissible,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: backgroundBlur ? 3 : 0,
            sigmaY: backgroundBlur ? 3 : 0,
          ),
          child: Dialog(
            backgroundColor: AppColors.white,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 24,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            //this right here
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (titleImgPath != null)
                    CircleAvatar(
                      backgroundColor: AppColors.iconBg,
                      radius: 48,
                      child: SvgPicture.asset(titleImgPath!),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyles.h6SemiBold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: TextStyles.body1Regular.copyWith(
                      color: AppColors.neutral5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (customWidget != null) customWidget!,
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      if (negativeText != "")
                        Expanded(
                          child: AppButton(
                            buttonTextPadding: EdgeInsets.zero,
                            buttonText: negativeText,
                            onPressed: () {
                              onNegativeTap?.call();
                              if (closeDialogOnBtnClick) context.pop();
                            },
                            textStyle: TextStyles.body1SemiBold.copyWith(
                              color: negativeTextColor,
                            ),
                            buttonColor: negativeBtnColor,
                          ),
                        ),
                      if (negativeText != "") const SizedBox(width: 15),
                      Expanded(
                        child: AppButton(
                          buttonTextPadding: EdgeInsets.zero,
                          buttonText: positiveText,
                          buttonColor: positiveBtnColor,
                          textStyle: TextStyles.body1SemiBold.copyWith(
                            color: positiveTextColor,
                          ),
                          onPressed: () {
                            if (closeDialogOnBtnClick) context.pop();
                            onPositiveTap?.call();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
