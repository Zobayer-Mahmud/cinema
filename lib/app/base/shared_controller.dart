import 'package:cinema/app/api/service/movie_service.dart';
import 'package:cinema/app/data/response/genre/genre_list_response.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SharedController extends GetxController {
  final Logger logger = Logger();
  List<Genres> genresList = [];


}
