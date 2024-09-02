import 'package:cinema/app/common/app_colors.dart';
import 'package:cinema/app/modules/app_widgets/arrow_back_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_play_controller.dart';

class VideoPlayView extends GetView<VideoPlayController> {
  const VideoPlayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBackButton(),
        title: const Text('Watch Trailer'),
        centerTitle: true,
      ),
      body: YoutubePlayer(
        controller: controller.youtubePlayerController,
        showVideoProgressIndicator: true,
        onReady: controller.onPlay,
        progressIndicatorColor: AppColors.primaryColor,
      ),
    );
  }
}
