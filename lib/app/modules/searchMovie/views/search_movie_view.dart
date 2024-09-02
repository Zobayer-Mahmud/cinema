import 'package:cinema/app/modules/app_widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../common/app_constants.dart';
import '../../../common/app_dimens.dart';
import '../../../routes/app_pages.dart';
import '../../app_widgets/custom_image.dart';
import '../../app_widgets/custom_search_box.dart';
import '../controllers/search_movie_controller.dart';

class SearchMovieView extends StatelessWidget {
  const SearchMovieView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchMovieController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Search Movie'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Awesome! Get your movie",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const Gap(AppDimens.paddingMedium),
                      CustomSearchBox(
                          hintText: "Search here",
                          textEditingController: controller.searchController,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(3),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 18,
                            ),
                          )),
                      const Gap(AppDimens.paddingMedium),
                    ],
                  )),
              if (controller.suggestion.isNotEmpty)
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        // color: Colors.white,
                        ),
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.suggestion.length,
                        itemBuilder: (context, index) {
                          var item = controller.suggestion[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.MOVIE_DETAILS, parameters: {
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name ?? item.title ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (item.firstAirDate != null)
                                          Text(
                                            item.firstAirDate?.year
                                                    .toString() ??
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
                  ),
                )
              else if (controller.searchController.text.isNotEmpty)
                const NotFoundWidget(
                  notFoundText: "Sorry!, no movie found!",
                )
            ],
          ));
    });
  }
}
