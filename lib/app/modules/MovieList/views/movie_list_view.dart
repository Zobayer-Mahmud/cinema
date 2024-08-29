import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/movie_list_controller.dart';

class MovieListView extends GetView<MovieListController> {
  const MovieListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MovieListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
