import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/data/response/movie/movie_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/response/genre/genre_list_response.dart';
import '../../../data/response/movie/movie_model.dart';
import '../../../routes/app_pages.dart';

class MovieListController extends BaseController {
  MovieService movieService = Get.find();
  bool showLoading = false;
  @override
  onReady() async {
    getGenreList();
    getTrendingMovieList();
  }

  List<MovieModel> trendingList = [];
  getGenreList() async {
    GenreListResponse? genreListResponse =
        await movieService.getMovieGenreList();
    sharedController.genresList = genreListResponse?.genres ?? [];
    sharedController.update();
  }

  void getTrendingMovieList() async {
    MovieListResponse? movieListResponse = await movieService.getMoviesList();
    trendingList = movieListResponse?.movies ?? [];
    update();
  }

  void onTrendingNowSeeMore() {
    Get.toNamed(Routes.MOVIES_BY_CATEGORY,
        parameters: {'tye': "trending_movie"});
  }
}
