import 'dart:async';

import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/data/response/movie/movie_list_response.dart';
import 'package:cinema/app/data/response/movie/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchMovieController extends BaseController {
  MovieService movieService = Get.find();
  TextEditingController searchController = TextEditingController();
  List<MovieModel> suggestion = [];
  Timer? _debounce;

  @override
  onInit() {
    initListener();
    super.onInit();
    update();
  }

  initListener() async {
    searchController.addListener(onSearchChanged);
  }

  void onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (searchController.text.isNotEmpty) {
        MovieListResponse? movieListResponse =
            await movieService.searchMovie(title: searchController.text);
        suggestion = movieListResponse?.movies ?? [];
      } else {
        suggestion.clear();
      }
      update();
    });
  }
}
