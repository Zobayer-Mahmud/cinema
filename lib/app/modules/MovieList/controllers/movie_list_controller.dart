import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/data/response/movie/movie_list_response.dart';
import 'package:cinema/app/utils/enums/movie_list_type.dart';
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
    await getInitialData();
  }

  getInitialData() async {
    showLoading = true;
    update();
    getGenreList();
    await getTrendingMovieList();
    await getPopularMovieList();
    await getUpcomingMovieList();
    showLoading = false;
    update();
  }

  List<MovieModel> trendingList = [];
  List<MovieModel> popularList = [];
  List<MovieModel> upcomingList = [];
  getGenreList() async {
    GenreListResponse? genreListResponse =
        await movieService.getMovieGenreList();
    sharedController.genresList = genreListResponse?.genres ?? [];
    sharedController.update();
  }

  getTrendingMovieList() async {
    MovieListResponse? movieListResponse =
        await movieService.getMoviesList(type: MovieListType.trending);
    trendingList = movieListResponse?.movies ?? [];
    update();
  }

  getPopularMovieList() async {
    MovieListResponse? movieListResponse =
        await movieService.getMoviesList(type: MovieListType.popular);
    popularList = movieListResponse?.movies ?? [];
    update();
  }

  getUpcomingMovieList() async {
    MovieListResponse? movieListResponse =
        await movieService.getMoviesList(type: MovieListType.upcoming);
    upcomingList = movieListResponse?.movies ?? [];
    update();
  }

  void onTrendingNowSeeMore() {
    Get.toNamed(Routes.MOVIES_BY_CATEGORY,
        parameters: {'type': MovieListType.trending.toShortString()});
  }

  void onPopularSeeMore() {
    Get.toNamed(Routes.MOVIES_BY_CATEGORY,
        parameters: {'type': MovieListType.popular.toShortString()});
  }

  void onUpcomingSeeMore() {
    Get.toNamed(Routes.MOVIES_BY_CATEGORY,
        parameters: {'type': MovieListType.upcoming.toShortString()});
  }
}
