import 'dart:async';

import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/data/response/genre/genre_list_response.dart';
import 'package:cinema/app/modules/MovieList/controllers/movie_list_controller.dart';
import 'package:cinema/app/utils/enums/movie_list_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../common/app_constants.dart';
import '../../../data/response/movie/movie_list_response.dart';
import '../../../data/response/movie/movie_model.dart';
import '../../app_widgets/floating_menu_panel.dart';
import '../views/genre_filter_bottom_sheet.dart';

class MoviesByCategoryController extends BaseController {
  MovieService movieService = Get.find();
  Timer? _debounce;
  List<MovieModel> movies = [];
  List<Genres> genres = [];
  List<Genres> selectedGenres = [];
  num currentPage = 1;
  ScrollController scrollController = ScrollController();
  PanelState panelState = PanelState.closed;

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
    genres = sharedController.genresList;
    loadSelectedGenres();

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

  onFloatingPressed(int index) {
    if (index == 0) {
      showGenreFilterSheet();
    }
  }

  void showGenreFilterSheet() async {
    await Get.bottomSheet(
      const GenreFilterBottomSheet(),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.white30,
    );
  }

  void onOutTap() {
    panelState = PanelState.closed;
    update();
  }

  toggleGenre(Genres genre) {
    var preferencesBox = Hive.box(AppConstants.preferencesKey);

    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
      preferencesBox.delete(genre.id);
    } else {
      selectedGenres.add(genre);
      preferencesBox.put(genre.id, genre.toJson());
    }
    update();
  }

  bool isAddedInPreference(Genres genre) {
    var preferencesBox = Hive.box(AppConstants.preferencesKey);
    return preferencesBox.containsKey(genre.id);
  }

  void loadSelectedGenres() {
    var preferencesBox = Hive.box(AppConstants.preferencesKey);
    selectedGenres =
        preferencesBox.values.map((json) => Genres.fromJson(json)).toList();
    update();
  }

  void onFilterContinue() {}
}
