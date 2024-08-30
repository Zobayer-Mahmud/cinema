import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/data/response/movie/movie_details.dart';
import 'package:get/get.dart';

import '../../../base/shared_controller.dart';
import '../../../routes/app_pages.dart';

class MovieDetailsController extends BaseController {
  MovieService movieService = Get.find();
  bool showLoading = false;
  num? movieId;
  MovieDetails? movieDetails;
  @override
  void onInit() {
    movieId = num.tryParse(Get.parameters['id'] ?? '');
    super.onInit();
  }

  @override
  void onReady() async {
    if (movieId != null) await getMovieDetails();
    super.onReady();
  }

  getMovieDetails() async {
    showLoading = true;
    update();
    movieDetails = await movieService.getMoviesDetails(movieId: movieId);
    showLoading = false;
    update();
  }
}
