import 'dart:async';

import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/utils/enums/movie_list_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/response/movie/movie_list_response.dart';
import '../../../data/response/movie/movie_model.dart';

class MoviesByCategoryController extends GetxController {
  MovieService movieService = Get.find();
  Timer? _debounce;
  List<MovieModel> movies = [];
  num currentPage = 1;
  ScrollController scrollController = ScrollController();

  num? lastPage;
  bool isLoading = false;
  MovieListType movieListType = MovieListType.trending;
  @override
  void onInit() {
    if (Get.parameters['type'] != null) {
      movieListType = MovieListTypeExtension.fromString(
              Get.parameters['type'] ?? 'trending') ??
          MovieListType.trending;
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await getTrendingMovieList();
    super.onReady();
  }

  getCallForPagination() async {
    if (currentPage <= (lastPage ?? 0)) {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        currentPage++;
        await getTrendingMovieList();
        update();
      });
    }
  }

  getTrendingMovieList({num? pageNo}) async {
    currentPage = pageNo ?? currentPage;
    if (currentPage == 1 && pageNo == null) {
      isLoading = true;
      update();
    }
    MovieListResponse? movieListResponse = await movieService.getMoviesList(
        page: currentPage, type: movieListType);
    movies.addAll(movieListResponse?.movies as Iterable<MovieModel>);
    lastPage = movieListResponse?.totalPages;
    isLoading = false;
    update();
  }

  bool onNotification(ScrollNotification scrollNotification) {
    //get height of each item
    var height = scrollNotification.metrics.maxScrollExtent / movies.length;
    //get position of item
    var position = ((scrollNotification.metrics.maxScrollExtent -
                scrollNotification.metrics.extentAfter) /
            height)
        .round();
    // print('postion is $position and the lenght is ${userList.length}');

    if (scrollNotification.metrics.maxScrollExtent ==
            scrollNotification.metrics.pixels ||
        movies.length - position == 50) {
      getCallForPagination();
      return true;
    }

    return false;
  }
}
