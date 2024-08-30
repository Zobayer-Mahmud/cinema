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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Trending Now',
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
            const Gap(10),
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
          ],
        ),
      );
    });
  }
}
