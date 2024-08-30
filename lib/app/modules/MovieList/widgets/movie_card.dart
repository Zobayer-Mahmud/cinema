import 'package:cinema/app/data/response/movie/movie_model.dart';
import 'package:cinema/app/modules/app_widgets/custom_image.dart';
import 'package:cinema/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.MOVIE_DETAILS,
            parameters: {"id": movie.id?.toString() ?? ""});
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: Get.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (movie.posterPath != null)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomImage(
                    image: movie.posterPath,
                    fit: BoxFit.cover,
                    width: Get.width * 0.4,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text(movie.name ?? movie.title ?? "",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium),
                  if (movie.firstAirDate != null)
                    Text("${movie.firstAirDate?.year}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey)),
                  if (movie.genres?.isNotEmpty == true)
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: (movie.genres?.length ?? 0) > 3
                              ? 3
                              : movie.genres?.length,
                          itemBuilder: (context, index) {
                            var item = movie.genres?[index];
                            return item?.name?.toLowerCase() != "unknown"
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text("${item?.name ?? ''},",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.grey)),
                                  )
                                : const SizedBox();
                          }),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
