import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/app/common/app_constants.dart';
import 'package:cinema/app/common/app_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCrewCard extends StatelessWidget {
  final String? imageUrl;
  final String? actorName;
  final String? role;

  const CartCrewCard({
    super.key,
    this.imageUrl,
    this.actorName,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Actor image in a circular shape
        CircleAvatar(
          radius: 40,
          backgroundImage: CachedNetworkImageProvider(
              "${AppConstants.imageBaseUrl}$imageUrl"),
        ),
        const Gap(AppDimens.paddingMedium), // Actor name and role
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              actorName ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(AppDimens.paddingExtraSmall),
            Text(
              role ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
