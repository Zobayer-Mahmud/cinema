import 'package:cinema/app/data/response/movie/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: Get.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (movie.posterUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.posterUrl!,
                height: 140,
                fit: BoxFit.cover,
                width: Get.width * 0.4,
              ),
            ),
          const SizedBox(height: 8),
          Center(
              child: Text(movie.title ?? "",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge)),
          Center(
            child: Text(movie.genre ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
