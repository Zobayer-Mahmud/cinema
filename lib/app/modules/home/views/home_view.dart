import 'package:cinema/app/modules/MovieList/views/movie_list_view.dart';
import 'package:cinema/app/modules/favourites/views/favourites_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/app_colors.dart';
import '../../../utils/utility.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          showExitDialog(context);
        },
        child: Scaffold(
            body: Stack(
              children: [
                IndexedStack(
                  index: controller.selectedIndex,
                  children: const [
                    MovieListView(),
                    FavouritesView(),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 84,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 20),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavItem(
                      label: 'Movies',
                      isSelected: controller.selectedIndex == 0,
                      icon: Icons.home_outlined,
                      onPressed: () => controller.changeIndex(0),
                    ),
                    BottomNavItem(
                      label: 'Favourites ',
                      isSelected: controller.selectedIndex == 1,
                      icon: Icons.favorite_border,
                      onPressed: () => controller.changeIndex(1),
                    ),
                  ],
                ),
              ),
            )),
      );
    });
  }
}

class BottomNavItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData icon;
  final VoidCallback onPressed;

  const BottomNavItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected ? AppColors.cyanColor : Colors.grey,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isSelected ? AppColors.cyanColor : Colors.grey,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}
