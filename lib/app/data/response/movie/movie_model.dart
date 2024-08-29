class MovieModel {
  MovieModel({
    this.id,
    this.title,
    this.director,
    this.cast,
    this.releaseDate,
    this.genre,
    this.rating,
    this.description,
    this.posterUrl,
  });

  MovieModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    director = json['director'];
    cast = json['cast'] != null ? json['cast'].cast<String>() : [];
    releaseDate = json['releaseDate'];
    genre = json['genre'];
    rating = json['rating'];
    description = json['description'];
    posterUrl = json['posterUrl'];
  }
  String? id;
  String? title;
  String? director;
  List<String>? cast;
  String? releaseDate;
  String? genre;
  num? rating;
  String? description;
  String? posterUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['director'] = director;
    map['cast'] = cast;
    map['releaseDate'] = releaseDate;
    map['genre'] = genre;
    map['rating'] = rating;
    map['description'] = description;
    map['posterUrl'] = posterUrl;
    return map;
  }
}
