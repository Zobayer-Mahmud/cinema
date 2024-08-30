import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/base/base_controller.dart';
import 'package:cinema/app/data/response/movie/movie_details.dart';
import 'package:cinema/app/data/response/movie_credit_response.dart';
import 'package:get/get.dart';

class MovieDetailsController extends BaseController {
  MovieService movieService = Get.find();
  bool showLoading = false;
  num? movieId;
  MovieDetails? movieDetails;
  List<Cast> casts = [];
  List<Crew> crews = [];
  @override
  void onInit() {
    movieId = num.tryParse(Get.parameters['id'] ?? '');
    print("MovieId ===>$movieId");
    super.onInit();
  }

  @override
  void onReady() async {
    if (movieId != null) await getMovieInfo();
    super.onReady();
  }

  getMovieInfo() async {
    showLoading = true;
    update();
    await getMovieDetails();

    showLoading = false;
    update();
    await getMovieCastAndCrew();
  }

  getMovieDetails() async {
    movieDetails = await movieService.getMoviesDetails(movieId: movieId);
    update();
  }

  getMovieCastAndCrew() async {
    MovieCreditResponse? movieCreditResponse =
        await movieService.getMovieCastAndCrewByMovieId(movieId: movieId);
    casts = movieCreditResponse?.cast ?? [];
    crews = movieCreditResponse?.crew ?? [];
    update();
  }
}
