import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/modules/app_widgets/app_loader.dart';
import 'package:cinema/app/modules/app_widgets/arrow_back_button.dart';
import 'package:cinema/app/utils/enums/movie_list_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_dimens.dart';
import '../../../routes/app_pages.dart';
import '../../app_widgets/custom_image.dart';
import '../../app_widgets/floating_menu_panel.dart';
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
            title:
                Text(controller.movieListType.toShortString().capitalizeFirst!),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              RefreshIndicator(
                  onRefresh: () => controller.getTrendingMovieList(pageNo: 1),
                  child: controller.isLoading
                      ? const AppLoader()
                      : controller.movies.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.all(AppDimens.paddingMedium),
                              child: NotificationListener<ScrollNotification>(
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
                                                  "id":
                                                      item.id?.toString() ?? ""
                                                });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom:
                                                    AppDimens.paddingMedium),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                  child: CustomImage(
                                                      image:
                                                          "${AppConstants.imageBaseUrl}${item.posterPath}",
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover),
                                                ),
                                                const Gap(
                                                    AppDimens.paddingMedium),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.name ??
                                                            item.title ??
                                                            '',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      if (item.firstAirDate !=
                                                          null)
                                                        Text(
                                                          item.firstAirDate
                                                                  ?.year
                                                                  .toString() ??
                                                              '',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            )
                          : const NotFoundWidget()),
              FloatingMenuPanel(
                  panelState: controller.panelState,
                  onPressed: controller.onFloatingPressed,
                  panelIconPath: Assets.svg.oliveWhite,
                  backgroundColor: AppColors.primaryColor,
                  buttons: [Assets.svg.filter])
            ],
          ));
    });
  }
}
