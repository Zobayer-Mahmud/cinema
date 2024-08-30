import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../app_widgets/arrow_back_button.dart';
import '../controllers/movie_details_controller.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  const MovieDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: const Text('MovieDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MovieDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
