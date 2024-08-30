import 'package:cinema/app/base/shared_controller.dart';
import 'package:get/get.dart';

import '../genre/genre_list_response.dart';

class MovieModel {
  MovieModel({
    this.backdropPath,
    this.id,
    this.name,
    this.originalName,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.adult,
    this.originalLanguage,
    this.genreIds,
    this.genres,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
  });

  MovieModel.fromJson(dynamic json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    title = json['title'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    adult = json['adult'];
    originalLanguage = json['original_language'];
    genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    if (genreIds != null && Get.isRegistered<SharedController>() == true) {
      genres =
          getGenresFromIds(genreIds!, Get.find<SharedController>().genresList);
    }
    popularity = json['popularity'];
    if (json['first_air_date'] != null) {
      firstAirDate = DateTime.tryParse(json['first_air_date']);
    }
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    originCountry = json['origin_country'] != null
        ? json['origin_country'].cast<String>()
        : [];
  }
  String? backdropPath;
  num? id;
  String? name;
  String? originalName;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  bool? adult;
  String? originalLanguage;
  List<num>? genreIds;
  List<Genres>? genres;
  num? popularity;
  DateTime? firstAirDate;
  num? voteAverage;
  num? voteCount;
  List<String>? originCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['backdrop_path'] = backdropPath;
    map['id'] = id;
    map['name'] = name;
    map['original_name'] = originalName;
    map['title'] = title;
    map['original_title'] = originalTitle;
    map['overview'] = overview;
    map['poster_path'] = posterPath;
    map['media_type'] = mediaType;
    map['adult'] = adult;
    map['original_language'] = originalLanguage;
    map['genre_ids'] = genreIds;
    map['popularity'] = popularity;
    map['first_air_date'] = firstAirDate;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    map['origin_country'] = originCountry;
    return map;
  }

  List<Genres> getGenresFromIds(List<num> genreIds, List<Genres> genresList) {
    return genreIds.map((id) {
      return genresList.firstWhere(
        (genre) => genre.id == id,
        orElse: () =>
            Genres(id: id, name: 'Unknown'), // Optional: handle unknown IDs
      );
    }).toList();
  }
}
