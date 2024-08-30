import 'package:get/get.dart';

import '../controllers/movies_by_category_controller.dart';

class MoviesByCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoviesByCategoryController>(
      () => MoviesByCategoryController(),
    );
  }
}
