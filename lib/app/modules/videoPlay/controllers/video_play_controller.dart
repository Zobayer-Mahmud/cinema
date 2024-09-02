import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayController extends GetxController {
  late YoutubePlayerController youtubePlayerController;

  String? videoKey;
  @override
  void onInit() {
    super.onInit();
    if (Get.parameters['video_key'] != null) {
      videoKey = Get.parameters['video_key'];
    }
    if (videoKey != null) {
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoKey!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  void onPlay() {
    youtubePlayerController?.play();
  }
}
