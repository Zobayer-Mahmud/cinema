import 'package:get/get.dart';

import '../modules/MovieDetails/bindings/movie_details_binding.dart';
import '../modules/MovieDetails/views/movie_details_view.dart';
import '../modules/MovieList/bindings/movie_list_binding.dart';
import '../modules/MovieList/views/movie_list_view.dart';
import '../modules/favourites/bindings/favourites_binding.dart';
import '../modules/favourites/views/favourites_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

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
  ];
}
