import 'package:cinema/app/api/service/movie_service.dart';
import 'package:get/get.dart';

import '../../../data/response/movie/movie_list_response.dart';
import '../../../data/response/movie/movie_model.dart';

class MoviesByCategoryController extends GetxController {
  MovieService movieService = Get.find();
  List<MovieModel> movies = [];
  num page = 1;
  bool isLoading = false;
  @override
  void onReady() async {
    await getTrendingMovieList();
    super.onReady();
  }

  getTrendingMovieList() async {
    MovieListResponse? movieListResponse =
        await movieService.getMoviesList(page: page);
    movies = movieListResponse?.movies ?? [];
    update();
  }
}
