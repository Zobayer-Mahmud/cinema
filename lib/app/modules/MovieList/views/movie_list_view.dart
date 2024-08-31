import 'package:cinema/app/common/app_colors.dart';
import 'package:cinema/app/common/app_dimens.dart';
import 'package:cinema/app/modules/MovieList/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/movie_list_controller.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieListController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingMedium,
              vertical: AppDimens.paddingMedium),
          children: [
            if (controller.trendingList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending',
                      style: Theme.of(context).textTheme.titleSmall),
                  GestureDetector(
                    onTap: controller.onTrendingNowSeeMore,
                    child: Text('See More',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            )),
                  ),
                ],
              ),
            if (controller.trendingList.isNotEmpty) const Gap(10),
            if (controller.trendingList.isNotEmpty)
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.trendingList.length,
                  itemBuilder: (_, index) {
                    var movie = controller.trendingList[index];
                    return MovieCard(movie: movie);
                  },
                ),
              ),
            if (controller.trendingList.isNotEmpty)
              const Gap(AppDimens.paddingSmall),
            if (controller.popularList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Popular',
                      style: Theme.of(context).textTheme.titleSmall),
                  GestureDetector(
                    onTap: controller.onPopularSeeMore,
                    child: Text('See More',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            )),
                  ),
                ],
              ),
            if (controller.popularList.isNotEmpty) const Gap(10),
            if (controller.popularList.isNotEmpty)
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.popularList.length,
                  itemBuilder: (_, index) {
                    var movie = controller.popularList[index];
                    return MovieCard(movie: movie);
                  },
                ),
              ),
            if (controller.popularList.isNotEmpty)
              const Gap(AppDimens.paddingSmall),
            if (controller.upcomingList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Upcoming',
                      style: Theme.of(context).textTheme.titleSmall),
                  GestureDetector(
                    onTap: controller.onUpcomingSeeMore,
                    child: Text('See More',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            )),
                  ),
                ],
              ),
            if (controller.upcomingList.isNotEmpty) const Gap(10),
            if (controller.upcomingList.isNotEmpty)
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.upcomingList.length,
                  itemBuilder: (_, index) {
                    var movie = controller.upcomingList[index];
                    return MovieCard(movie: movie);
                  },
                ),
              ),
          ],
        ),
      );
    });
  }
}
