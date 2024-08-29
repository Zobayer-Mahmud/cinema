import 'package:cinema/app/common/app_constants.dart';
import 'package:get/get.dart';

import '../../../data/response/movie/movie_model.dart';

class MovieListController extends GetxController {
  List<MovieModel> trendingList = [
    MovieModel(
      title: 'Monster Hunter',
      genre: 'Action, Adventure',
      posterUrl: AppConstants.dummyImageURL,
    ),
    MovieModel(
      title: 'The New Mutants',
      genre: 'Action, Horror, Sci-Fi',
      posterUrl: AppConstants.dummyImageURL,
    ),
    MovieModel(
      title: 'Wonder Woman 1984',
      genre: 'Action',
      posterUrl: AppConstants.dummyImageURL,
    ),
    MovieModel(
      title: 'Tenet',
      genre: 'Action, Thriller, Sci-Fi',
      posterUrl: AppConstants.dummyImageURL,
    ),
  ];
}
