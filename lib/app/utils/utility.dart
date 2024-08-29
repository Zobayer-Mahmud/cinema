import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enums/toast_type.dart';

String getPlatformName() {
  if (GetPlatform.isAndroid) {
    return 'Android';
  } else if (GetPlatform.isIOS) {
    return 'iOS';
  } else if (GetPlatform.isWeb) {
    return 'Web';
  } else if (GetPlatform.isMacOS) {
    return 'macOS';
  } else if (GetPlatform.isWindows) {
    return 'Windows';
  } else if (GetPlatform.isLinux) {
    return 'Linux';
  } else {
    return 'Unknown';
  }
}

void showDelightToast(
    {List<String>? images,
    required String title,
    String? subtitle,
    IconData? icon,
    String? image,
    Color? iconBgColor,
    Duration? duration,
    bool autoDismiss = true,
    ToastType type = ToastType.warning,
    DelightSnackbarPosition position = DelightSnackbarPosition.top,
    VoidCallback? onTap}) {
  DelightToastBar(
    snackbarDuration: duration ?? const Duration(seconds: 2),
    animationDuration: const Duration(milliseconds: 700),
    autoDismiss: autoDismiss,
    position: position,
    builder: (context) => ToastCard(
      onTap: onTap,
      title: Text(title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: type == ToastType.fail ? Colors.red : Colors.black)),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
    ),
  ).show(Get.context!);
}
