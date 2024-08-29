import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../common/app_colors.dart';
import '../modules/app_widgets/custom_gradient_button.dart';

showConfirmationDialog({
  required BuildContext context,
  String? svgImage,
  String? title,
  String? tag,
  String? subTitle,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  ColorFilter? colorFilter,
  TextStyle? titleStyle,
  double? svgImageHeight,
  double? svgImageWidth,
  bool barrierDismissible = true,
  bool showCloseButton = false,
  TextStyle? cancelTextStyle,
}) async {
  await showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCloseButton)
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: Get.back,
                        child: Icon(
                          Icons.close,
                          color: AppColors.primaryColor,
                        ))),
              if (svgImage != null)
                SvgPicture.asset(
                  svgImage,
                  colorFilter: colorFilter,
                  height: svgImageHeight ?? 50,
                  width: svgImageWidth ?? 50,
                ),
              if (svgImage != null) const SizedBox(height: 16),
              if (tag != null)
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    tag,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              if (tag != null) const Gap(10),
              if (title != null)
                Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: titleStyle ??
                        Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              if (title != null) const Gap(16),
              if (subTitle != null)
                Center(
                  child: Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (subTitle != null) const Gap(24),
              if (onConfirm != null)
                CustomGradientButton(
                  text: confirmText ?? "Yes",
                  onTap: onConfirm,
                ),
              if (onConfirm != null) const Gap(10),
              if (onCancel != null)
                GestureDetector(
                  onTap: onCancel,
                  child: Text(
                    cancelText ?? "No",
                    style: cancelTextStyle ??
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xff2AAEF8),
                            fontWeight: FontWeight.bold),
                  ),
                ),
              const Gap(15),
            ],
          ),
        ),
      );
    },
  );
}
