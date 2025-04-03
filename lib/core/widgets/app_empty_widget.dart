import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../themes/app_colors.dart';
import '../themes/text_styles.dart';
import 'app_button.dart';

class AppEmptyWidget extends StatelessWidget {
  final String imgPath;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool addListView;

  const AppEmptyWidget({
    super.key,
    required this.imgPath,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onPressed,
    this.addListView = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Allows pull to refresh
        if (addListView)
          ListView(physics: const AlwaysScrollableScrollPhysics()),

        // Empty view centered
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // img
              Visibility(
                visible: imgPath.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 24),
                  child: Skeleton.replace(
                    replacement: const Bone.circle(size: 60),
                    child:
                    extension(imgPath) == ".svg"
                        ? SvgPicture.asset(imgPath, height: 160, width: 240)
                        : Image.asset(imgPath),
                  ),
                ),
              ),

              // title
              if (title.isNotEmpty)
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 16),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyles.h6SemiBold,
                  ),
                ),

              // subtitle
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyles.body1Regular.copyWith(
                      color: AppColors.neutral5,
                    ),
                  ),
                ),

              // button
              if (buttonText != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 24),
                  child: Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      onPressed: onPressed,
                      buttonText: buttonText!,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
