import 'package:flutter/material.dart';

class CustomSearchBox extends StatelessWidget {
  const CustomSearchBox(
      {super.key,
      this.textEditingController,
      this.hintText,
      this.suffixIcon,
      this.onChanged,
      this.suffixHeight,
      this.suffixWidth});
  final TextEditingController? textEditingController;
  final String? hintText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? suffixHeight, suffixWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        controller: textEditingController,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.black),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black.withOpacity(0.4)),
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: suffixIcon != null
              ? SizedBox(
                  height: suffixHeight ?? 35,
                  width: suffixWidth ?? 35,
                  child: suffixIcon)
              : null,
        ),
      ),
    );
  }
}
