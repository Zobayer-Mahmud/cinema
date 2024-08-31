import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../common/app_constants.dart';
import '../../../common/app_dimens.dart';
import '../../../routes/app_pages.dart';
import '../../app_widgets/custom_image.dart';
import '../../app_widgets/not_found_widget.dart';
import '../controllers/favourites_controller.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Favourites"),
            centerTitle: true,
          ),
          body: controller.movies.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListView.builder(
                      itemCount: controller.movies.length,
                      itemBuilder: (context, index) {
                        var item = controller.movies[index];

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.MOVIE_DETAILS,
                                parameters: {"id": item.id?.toString() ?? ""});
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: AppDimens.paddingMedium),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: CustomImage(
                                          image:
                                              "${AppConstants.imageBaseUrl}${item.posterPath}",
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                        right: 0,
                                        child: InkWell(
                                          onTap: () =>
                                              controller.toggleFavorite(item),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            padding: const EdgeInsets.all(3),
                                            child: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                const Gap(AppDimens.paddingMedium),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (item.releaseDate != null)
                                        Text(
                                          item.releaseDate?.year.toString() ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.grey),
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : const NotFoundWidget(
                  notFoundText: "No favourites movie found!",
                ));
    });
  }
}
