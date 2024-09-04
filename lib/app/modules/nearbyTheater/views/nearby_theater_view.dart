import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema/app/modules/app_widgets/app_loader.dart';
import 'package:cinema/app/modules/app_widgets/arrow_back_button.dart';
import 'package:cinema/app/modules/app_widgets/not_found_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/nearby_theater_controller.dart';

class NearbyTheaterView extends StatelessWidget {
  const NearbyTheaterView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyTheaterController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: const ArrowBackButton(),
          title: const Text('Nearby Theaters'),
          centerTitle: true,
        ),
        body: controller.showLoading
            ? const Center(child: AppLoader())
            : controller.markers.isNotEmpty == true
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          controller.sharedController.userLocation!.latitude,
                          controller.sharedController.userLocation!.longitude),
                      zoom: 14,
                    ),
                    markers: controller.markers,
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.mapController = googleMapController;
                      // controller.setMapStyle(_mapStyle);
                    },
                  )
                : controller.theaterList.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10),
                        itemCount: controller.theaterList.length,
                        itemBuilder: (context, index) {
                          var theater = controller.theaterList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              backgroundImage: CachedNetworkImageProvider(
                                theater.icon ?? '',
                              ),
                            ),
                            title: Text(theater.name ?? ""),
                            subtitle: Text(theater.vicinity ?? ''),
                          );
                        },
                      )
                    : NotFoundWidget(
                        notFoundText: controller
                                    .sharedController.userLocation ==
                                null
                            ? "Couldn't found nearby theater without your location"
                            : "Couldn't found any nearby theater"),
      );
    });
  }
}
