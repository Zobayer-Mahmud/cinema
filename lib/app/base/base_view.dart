import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/app_widgets/app_loader.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  final bool showLoading;

  const BaseView({super.key, required this.child, this.showLoading = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (showLoading == true)
          SizedBox(
            height: Get.height,
            width: Get.width,
            // color: Colors.white54,
            child: AppLoader(),
          )
      ],
    );
  }
}
