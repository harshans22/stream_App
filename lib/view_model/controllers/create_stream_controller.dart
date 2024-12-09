import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stream_management_flutter/models/stream_model.dart';

import '../../repository/create_stream_repository.dart';

class UpdateStreamController extends GetxController {
  final _api = CreateStreamRepository();
  Timer? debounce;


  final platformController = TextEditingController().obs;
  final titleController = TextEditingController().obs;
  final thumbnailController = "".obs;
  final siteIconController = "".obs;
  final linkController = TextEditingController().obs;

  void fetchMetaData(String encodedUrl) async {
    await _api.getMetaData(encodedUrl).then((stream) {
      platformController.value.text = stream.platform;
      titleController.value.text = stream.title;
      thumbnailController.value = stream.thumbnail;
      siteIconController.value = stream.siteIcon;
      linkController.value.text = stream.link;
    }).onError((error, stackTrace) {
      Logger().e(error);
      //TODO:add error handling like api status
      Get.snackbar("Error", "Failed to fetch metadata",
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    });
  }

  void onInputChange(String input) {
    if (input.isEmpty) return;
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(seconds: 2), () {
      fetchMetaData(input); // Fetch data after 500ms of inactivity
    });
  }

  setAllControllers(StreamModel stream) {
    platformController.value.text = stream.platform;
    titleController.value.text = stream.title;
    thumbnailController.value = stream.thumbnail;
    siteIconController.value = stream.siteIcon;
    linkController.value.text = stream.link;
  }

  void setPlatform(String platform) {
    platformController.value.text = platform;
  }

  void setThumbnail(String thumbnail) {
    thumbnailController.value = thumbnail;
  }
}
