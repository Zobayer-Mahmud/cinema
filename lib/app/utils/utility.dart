import 'dart:io';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../gen/assets.gen.dart';
import '../modules/app_widgets/e_button.dart';
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

void showExitDialog(BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)), //this right here
        child: SizedBox(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Image.asset(Assets.png.imgExit.path)),
                const Text(
                  "Hope to see you soon !",
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const Text(
                  "Do you want to exit?",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: EButton(
                        height: 50,
                        text: "Cancel",
                        borderWidth: 1,
                        backgroundColor: Colors.white,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    const Gap(15),
                    Expanded(
                      child: EButton(
                          height: 50,
                          width: 150,
                          text: "Exit",
                          onPressed: () => exit(0)),
                    )
                  ],
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ));
}

