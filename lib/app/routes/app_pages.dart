import 'package:get/get.dart';

import '../modules/MovieDetails/bindings/movie_details_binding.dart';
import '../modules/MovieDetails/views/movie_details_view.dart';
import '../modules/MovieList/bindings/movie_list_binding.dart';
import '../modules/MovieList/views/movie_list_view.dart';
import '../modules/favourites/bindings/favourites_binding.dart';
import '../modules/favourites/views/favourites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/moviesByCategory/bindings/movies_by_category_binding.dart';
import '../modules/moviesByCategory/views/movies_by_category_view.dart';
import '../modules/nearbyTheater/bindings/nearby_theater_binding.dart';
import '../modules/nearbyTheater/views/nearby_theater_view.dart';
import '../modules/searchMovie/bindings/search_movie_binding.dart';
import '../modules/searchMovie/views/search_movie_view.dart';
import '../modules/videoPlay/bindings/video_play_binding.dart';
import '../modules/videoPlay/views/video_play_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_LIST,
      page: () => const MovieListView(),
      binding: MovieListBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAILS,
      page: () => const MovieDetailsView(),
      binding: MovieDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITES,
      page: () => const FavouritesView(),
      binding: FavouritesBinding(),
    ),
    GetPage(
      name: _Paths.MOVIES_BY_CATEGORY,
      page: () => const MoviesByCategoryView(),
      binding: MoviesByCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MOVIE,
      page: () => const SearchMovieView(),
      binding: SearchMovieBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAY,
      page: () => const VideoPlayView(),
      binding: VideoPlayBinding(),
    ),
    GetPage(
      name: _Paths.NEARBY_THEATER,
      page: () => const NearbyTheaterView(),
      binding: NearbyTheaterBinding(),
    ),
  ];
}
