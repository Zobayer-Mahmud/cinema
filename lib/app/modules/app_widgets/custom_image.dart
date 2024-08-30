import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import 'app_loader.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  final Widget? errorWidget;
  final Color? imageColor;

  const CustomImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    // print(image);
    return CachedNetworkImage(
      imageUrl: AppConstants.imageBaseUrl + image!,
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
      color: imageColor,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        color: Colors.grey.shade100,
        child: const Center(
            child: SizedBox(height: 20, width: 20, child: AppLoader())),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Image.asset(
            placeholder ?? Assets.png.placeHolder.path,
            // placeholder ?? Assets.jpg.groupPlaceholder.path,
            height: height,
            width: width,
            // fit: BoxFit.cover,
            fit: fit ?? BoxFit.fitWidth,
            color: Colors.blue.shade500,
          ),
    );
  }
}
