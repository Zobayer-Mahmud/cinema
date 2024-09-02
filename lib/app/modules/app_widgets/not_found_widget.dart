import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../../gen/assets.gen.dart';
import '../../common/app_dimens.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, this.notFoundText});
  final String? notFoundText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            Assets.lottie.notFound,
            height: 200.0,
          ),
        ),
        const SizedBox(height: 20),
        // "No movie details found" text
        Center(
          child: Text(
            notFoundText ?? 'No found',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
