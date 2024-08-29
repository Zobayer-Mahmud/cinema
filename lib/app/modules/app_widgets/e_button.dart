import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../common/app_colors.dart';
import 'app_loader.dart';

class EButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Color? loadingColor;
  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final double? radius;
  final double borderWidth;
  final Color? borderColor;
  final bool showLoader;
  final bool disable;
  final EdgeInsets? padding;

  EButton({
    super.key,
    required this.text,
    this.prefixIcon,
    this.disable = false,
    this.onPressed,
    this.backgroundColor,
    this.loadingColor,
    this.textStyle,
    this.elevation,
    this.height,
    this.radius,
    this.width,
    this.showLoader = false,
    this.borderWidth = 0,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52,
      width: width,
      child: ElevatedButton(
        onPressed: !showLoader && !disable ? onPressed : null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(disable
                ? Colors.grey
                : backgroundColor ?? AppColors.primaryColor),
            elevation: MaterialStateProperty.all<double>(elevation ?? 0.1),
            padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
            side: MaterialStateProperty.all(BorderSide(
              width: borderWidth,
              color: borderColor ?? AppColors.primaryColor,
            )),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 8),
            ))),
        child: showLoader
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLoader(
              height: 20,
              width: 20,
            ),
            const Gap(16),
            Text(
              'Loading . . .',
              style: textStyle ??
                  Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                text,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
