import 'package:cinema/app/modules/favourites/controllers/favourites_controller.dart';
import 'package:get/get.dart';

import '../../MovieList/controllers/movie_list_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MovieListController>(() => MovieListController());
    Get.lazyPut<FavouritesController>(() => FavouritesController());
  }
}
