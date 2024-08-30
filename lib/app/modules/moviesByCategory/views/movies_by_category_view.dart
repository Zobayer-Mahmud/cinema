import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/modules/app_widgets/app_loader.dart';
import 'package:cinema/app/modules/app_widgets/arrow_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../common/app_dimens.dart';
import '../../../routes/app_pages.dart';
import '../../app_widgets/custom_image.dart';
import '../../app_widgets/not_found_widget.dart';
import '../controllers/movies_by_category_controller.dart';

class MoviesByCategoryView extends StatelessWidget {
  const MoviesByCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoviesByCategoryController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: const ArrowBackButton(),
            title: const Text('MoviesByCategoryView'),
            centerTitle: true,
          ),
          body: controller.isLoading
              ? const AppLoader()
              : controller.movies.isNotEmpty
                  ? NotificationListener<ScrollNotification>(
                      onNotification: controller.onNotification,
                      child: AnimationLimiter(
                        child: ListView.builder(
                            controller: controller.scrollController,
                            itemCount: controller.movies.length,
                            itemBuilder: (context, index) {
                              var item = controller.movies[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.MOVIE_DETAILS,
                                      parameters: {
                                        "id": item.id?.toString() ?? ""
                                      });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: AppDimens.paddingMedium),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Row(
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
                                      const Gap(AppDimens.paddingMedium),
                                      Expanded(
                                        child: Text(
                                          item.name ?? item.title ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    )
                  : const NotFoundWidget());
    });
  }
}
