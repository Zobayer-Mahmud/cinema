import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    super.key,
    required this.text,
    this.radius,
    this.onTap,
    this.bgColor,
    this.textStyle,
    this.showGradient = true,
    this.isActive = true,
    this.prefixIcon,
    this.onSuffixTap,
    this.onPrefixTap,
    this.suffixIcon,
    this.mainAxisAlignment, this.padding,
  });
  final String text;
  final double? radius;
  final VoidCallback? onTap, onSuffixTap, onPrefixTap;
  final Color? bgColor;
  final TextStyle? textStyle;
  final bool showGradient;
  final bool isActive;
  final Widget? prefixIcon, suffixIcon;
  final MainAxisAlignment? mainAxisAlignment;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive ? onTap : null,
      child: Container(
        padding: padding?? const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
          gradient: showGradient
              ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff0F90D9),
              Color(0xff63C4FB),
            ],
          )
              : null,
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              GestureDetector(onTap: onPrefixTap, child: prefixIcon!),
            if (prefixIcon != null) const Gap(15),
            Text(
              text,
              style: textStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
            ),
            if (suffixIcon != null) const Gap(5),
            if (suffixIcon != null)
              GestureDetector(onTap: onSuffixTap, child: suffixIcon!),
          ],
        ),
      ),
    );
  }
}
