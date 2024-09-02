import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/common/app_dimens.dart';
import 'package:cinema/app/modules/app_widgets/app_loader.dart';
import 'package:cinema/app/modules/app_widgets/custom_image.dart';
import 'package:cinema/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../gen/assets.gen.dart';
import '../../app_widgets/arrow_back_button.dart';
import '../../app_widgets/cart_crew_card.dart';
import '../../app_widgets/genre_chip.dart';
import '../controllers/movie_details_controller.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MovieDetailsController>(builder: (controller) {
      return Scaffold(
        body: controller.showLoading
            ? const AppLoader()
            : controller.movieDetails != null
                ? ListView(
                    children: [
                      Stack(
                        children: [
                          CustomImage(
                            image:
                                "${AppConstants.imageBaseUrl}${controller.movieDetails?.posterPath}", // Replace with actual image URL
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const Positioned(
                            top: 40,
                            left: 16,
                            child: ArrowBackButton(),
                          ),
                          GetBuilder<FavouritesController>(
                              builder: (favController) {
                            return Positioned(
                              top: 40,
                              right: 16,
                              child: GestureDetector(
                                onTap: () => favController
                                    .toggleFavorite(controller.movieDetails!),
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: favController.isFavorite(
                                              controller.movieDetails!)
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.white30,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    favController.isFavorite(
                                            controller.movieDetails!)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favController.isFavorite(
                                            controller.movieDetails!)
                                        ? Colors.red
                                        : Colors.black12,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.all(AppDimens.paddingMedium),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.movieDetails?.title ??
                                      controller.movieDetails?.originalTitle ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                const Gap(8),
                                Row(
                                  children: [
                                    if (controller.movieDetails?.releaseDate !=
                                        null)
                                      Text(
                                        "${controller.movieDetails?.releaseDate?.year ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (controller.movieDetails?.releaseDate !=
                                        null)
                                      const Gap(8),
                                    if (controller.movieDetails?.runtime !=
                                        null)
                                      Text(
                                        '${controller.movieDetails?.runtime} m',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (controller.movieDetails?.runtime !=
                                        null)
                                      const SizedBox(width: 8),
                                    const Text(
                                      'R',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'HD',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                                const Gap(8),
                                Row(
                                  children: [
                                    if (controller.movieDetails?.popularity !=
                                        null)
                                      Expanded(
                                        child: Text(
                                          "${controller.movieDetails?.popularity?.toString() ?? ""} Popularity",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: Colors.green),
                                        ),
                                      ),
                                    if (controller.movieDetails?.popularity !=
                                        null)
                                      const Gap(4),
                                    if (controller.movieDetails?.voteAverage !=
                                        null)
                                      Text(
                                        "Vote avg: ${controller.movieDetails?.voteAverage ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    if (controller.movieDetails?.voteAverage !=
                                        null)
                                      const Gap(8),
                                    if (controller.movieDetails?.voteCount !=
                                        null)
                                      Text(
                                        'Vote count: ${controller.movieDetails?.voteCount}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                  ],
                                ),
                                const Gap(AppDimens.paddingMedium),
                                Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: controller.movieDetails?.genres
                                          ?.map((genre) => GenreChip(
                                                genreTitle: genre.name ?? '',
                                              ))
                                          .toList() ??
                                      [],
                                ),
                                const Gap(AppDimens.paddingMedium),
                                if (controller.movieDetails?.trailerUrl != null)
                                  ElevatedButton(
                                    onPressed: controller.onMovieTrailerPlay,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[800],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Text(
                                          'Play Trailer',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                const Gap(AppDimens.paddingMedium),
                                if (controller.movieDetails?.overview != null)
                                  const Text(
                                    'Prolog',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (controller.movieDetails?.overview != null)
                                  const Gap(8),
                                if (controller.movieDetails?.overview != null)
                                  Text(
                                    controller.movieDetails?.overview ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                const Gap(AppDimens.paddingMedium),
                                if (controller.movieDetails?.productionCompanies
                                        ?.isNotEmpty ==
                                    true)
                                  if (controller.movieDetails?.overview != null)
                                    const Text(
                                      'Production',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                if (controller.movieDetails?.overview != null)
                                  const Gap(AppDimens.paddingMedium),
                                if (controller.movieDetails?.productionCompanies
                                        ?.isNotEmpty ==
                                    true)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Circular logo or placeholder
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey.shade800,
                                        backgroundImage: controller
                                                    .movieDetails
                                                    ?.productionCompanies
                                                    ?.first
                                                    .logoPath !=
                                                null
                                            ? CachedNetworkImageProvider(
                                                "${AppConstants.imageBaseUrl}${controller.movieDetails!.productionCompanies!.first.logoPath!}")
                                            : null,
                                        child: controller
                                                    .movieDetails
                                                    ?.productionCompanies
                                                    ?.first
                                                    .logoPath ==
                                                null
                                            ? const Icon(
                                                Icons.business,
                                                color: Colors.white,
                                                size: 30,
                                              )
                                            : null,
                                      ),
                                      const Gap(AppDimens.paddingMedium),
                                      // Company name and country
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                    .movieDetails
                                                    ?.productionCompanies
                                                    ?.first
                                                    .name ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          const SizedBox(height: 5),
                                          if (controller
                                                      .movieDetails
                                                      ?.productionCompanies
                                                      ?.first
                                                      .originCountry !=
                                                  null ||
                                              controller
                                                      .movieDetails
                                                      ?.productionCountries
                                                      ?.isNotEmpty ==
                                                  true)
                                            Text(
                                              controller
                                                      .movieDetails
                                                      ?.productionCompanies
                                                      ?.first
                                                      .originCountry ??
                                                  (controller
                                                          .movieDetails
                                                          ?.productionCountries
                                                          ?.first
                                                          .name ??
                                                      ''),
                                              style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (controller.movieDetails?.productionCompanies
                                        ?.isNotEmpty ==
                                    true)
                                  const Gap(AppDimens.paddingMedium),
                                if (controller.casts.isNotEmpty == true)
                                  Text('Top Casts',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                if (controller.casts.isNotEmpty == true)
                                  const Gap(AppDimens.paddingSmall),
                                if (controller.casts.isNotEmpty == true)
                                  ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      padding: EdgeInsets.zero,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.casts.length > 5
                                          ? 5
                                          : controller.casts.length,
                                      itemBuilder: (context, index) {
                                        var cast = controller.casts[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: CartCrewCard(
                                            imageUrl: cast.profilePath,
                                            actorName: cast.name,
                                            role: cast.character,
                                          ),
                                        );
                                      }),
                                if (controller.crews.isNotEmpty == true &&
                                    controller.crews.first.job == "Director")
                                  Text('Directed By',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                if (controller.crews.isNotEmpty == true &&
                                    controller.crews.first.job == "Director")
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: CartCrewCard(
                                      imageUrl:
                                          controller.crews.first.profilePath,
                                      actorName: controller.crews.first.name,
                                      role: controller.crews.first.job,
                                    ),
                                  ),
                              ]))
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      const Padding(
                        padding: EdgeInsets.all(AppDimens.paddingMedium),
                        child: ArrowBackButton(),
                      ),
                      const Spacer(),
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
                          'No movie details found',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox()
                    ],
                  ),
      );
    });
  }
}
