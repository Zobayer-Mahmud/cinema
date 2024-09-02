import 'package:cinema/app/common/app_dimens.dart';
import 'package:cinema/app/modules/app_widgets/custom_gradient_button.dart';
import 'package:cinema/app/modules/moviesByCategory/controllers/movies_by_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../app_widgets/genre_chip.dart';

class GenreFilterBottomSheet extends StatelessWidget {
  const GenreFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviesByCategoryController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(AppDimens.paddingMedium),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black),
        child: Stack(
          children: [
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Filter",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    GestureDetector(
                      // onTap: Get.back,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "Clear",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(AppDimens.paddingMedium),
                Text(
                  "Set Genre Preference",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(AppDimens.paddingMedium),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: controller.genres
                          .map((genre) => GestureDetector(
                                onTap: () => controller.toggleGenre(genre),
                                child: GenreChip(
                                  isSelected:
                                      controller.isAddedInPreference(genre),
                                  genreTitle: genre.name ?? '',
                                ),
                              ))
                          .toList() ??
                      [],
                ),
                Gap(AppDimens.paddingExtraLarge),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 15,
                child: CustomGradientButton(text: "Continue",
                onTap: controller.onFilterContinue,)),
          ],
        ),
      );
    });
  }
}
