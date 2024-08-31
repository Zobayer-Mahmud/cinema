enum MovieListType {
  trending,
  popular,
  upcoming,
}

extension MovieListTypeExtension on MovieListType {
  String toShortString() {
    return toString().split('.').last;
  }

  // Static method to convert a String to MovieListType
  static MovieListType? fromString(String type) {
    switch (type) {
      case 'trending':
        return MovieListType.trending;
      case 'popular':
        return MovieListType.popular;
      case 'upcoming':
        return MovieListType.upcoming;
      default:
        return null; // or throw an exception if you want to handle invalid strings
    }
  }
}
