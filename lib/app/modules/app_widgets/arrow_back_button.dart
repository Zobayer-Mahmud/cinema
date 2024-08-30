import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? Get.back,
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 10),
        padding: EdgeInsets.all(5),
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
      ),
    );
  }
}
