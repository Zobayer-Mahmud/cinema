import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favourites_controller.dart';

class FavouritesView extends GetView<FavouritesController> {
  const FavouritesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavouritesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FavouritesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
