import 'package:cinema/app/api/api_client/api_response.dart';
import 'package:cinema/app/base/base_api_service.dart';
import 'package:cinema/app/common/api_endpoints.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/data/response/genre/genre_list_response.dart';
import 'package:cinema/app/data/response/movie/movie_details.dart';

import '../../data/response/movie/movie_list_response.dart';

class MovieService extends BaseApiService {
  Future<MovieDetails?> getMoviesDetails({num? movieId}) async {
    ApiResponse apiResponse = await dioClient.get(
      endpoint: "${ApiEndPoints.movie}/$movieId", /* queryParams: {
    }*/
    );
    try {
      if (apiResponse.success && apiResponse.response?.data != null) {
        return MovieDetails.fromJson(apiResponse.response?.data);
      } else {
        sharedController.logger.e("getMoviesDetails parse error $runtimeType");
      }
    } catch (e) {
      sharedController.logger.e("getMoviesDetails api error $runtimeType");
    }
    return null;
  }

  Future<MovieListResponse?> getMoviesList({num? page}) async {
    ApiResponse apiResponse = await dioClient
        .get(endpoint: ApiEndPoints.trendingAllDay, queryParams: {
      "page": page,
    });
    try {
      if (apiResponse.success && apiResponse.response?.data != null) {
        return MovieListResponse.fromJson(apiResponse.response?.data);
      } else {
        sharedController.logger.e("getMoviesList parse error $runtimeType");
      }
    } catch (e) {
      sharedController.logger.e("getMoviesList api error $runtimeType");
    }
    return null;
  }

  Future<GenreListResponse?> getMovieGenreList() async {
    ApiResponse apiResponse = await dioClient
        .get(endpoint: ApiEndPoints.genreMovieList, queryParams: {
      "language": "en",
    });
    try {
      if (apiResponse.success && apiResponse.response?.data != null) {
        return GenreListResponse.fromJson(apiResponse.response?.data);
      } else {
        sharedController.logger.e("getMovieGenreList parse error $runtimeType");
      }
    } catch (e) {
      sharedController.logger.e("getMovieGenreList api error $runtimeType");
    }
    return null;
  }
}
