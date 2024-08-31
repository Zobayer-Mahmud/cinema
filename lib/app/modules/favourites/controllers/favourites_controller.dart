import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/data/response/movie/movie_details.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavouritesController extends BaseController {
  List<MovieDetails> movies = [];
  @override
  onReady() {
    getFavoriteMovies();
  }

  getFavoriteMovies() {
    var favoritesBox = Hive.box(AppConstants.favouritesKey);
    movies =
        favoritesBox.values.map((json) => MovieDetails.fromJson(json)).toList();
    update();
  }

  void toggleFavorite(MovieDetails movie) {
    var favoritesBox = Hive.box(AppConstants.favouritesKey);
    if (favoritesBox.containsKey(movie.id)) {
      favoritesBox.delete(movie.id);
    } else {
      favoritesBox.put(movie.id, movie.toJson());
    }
    getFavoriteMovies();
    update();
  }

  bool isFavorite(MovieDetails movie) {
    var favoritesBox = Hive.box(AppConstants.favouritesKey);
    return favoritesBox.containsKey(movie.id);
  }
}
