import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({super.key, this.genreTitle, this.isSelected = false});
  final String? genreTitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white
            : Colors.transparent, // Transparent background
        borderRadius: BorderRadius.circular(30), // Rounded corners
        border: Border.all(
          color: Colors.white.withOpacity(0.5), // Light gray border
          width: 1.5,
        ),
      ),
      child: Text(
        genreTitle ?? '',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isSelected ? Colors.black : Colors.white,
            ),
      ),
    );
  }
}
