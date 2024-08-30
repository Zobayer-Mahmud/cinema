import 'movie_model.dart';

class MovieListResponse {
  MovieListResponse({
    this.page,
    this.movies,
    this.totalPages,
    this.totalResults,
  });

  MovieListResponse.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = [];
      json['results'].forEach((v) {
        movies?.add(MovieModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  num? page;
  List<MovieModel>? movies;
  num? totalPages;
  num? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (movies != null) {
      map['results'] = movies?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}


