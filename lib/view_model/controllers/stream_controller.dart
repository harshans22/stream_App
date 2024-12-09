// controllers/stream_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/stream_model.dart';

class LiveStreamController extends GetxController {
  final RxList<StreamModel> allstreams = <StreamModel>[].obs;
  final RxList<StreamModel> paginatedStream = <StreamModel>[].obs;
  var searchController = TextEditingController().obs;
  final RxBool isLoading = false.obs;
  int currentPage = 1;
  final int pageSize = 5;
  late ScrollController scrollController;
  var searchResults = <StreamModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    loadInitialData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void addStream(StreamModel stream) {
    allstreams.insert(0, stream);
    paginatedStream.insert(0, stream);
  }

  void updateStream(int index, StreamModel updatedStream) {
    allstreams[index] = updatedStream;
  }

  void deleteStream(int index) {
    allstreams.removeAt(index);
    paginatedStream.removeAt(index);
  }

  void loadInitialData() {
    // Add 30 prefilled items
    allstreams.addAll(List.generate(
      30,
      (index) => StreamModel(
        platform: 'YouTube',
        title:
            'Testing with Patrol | Observable Flutter | Flutter Tutorial for Beginners | Code With Andrea',
        thumbnail:
            'https://i.ytimg.com/vi/okqC1Q5aEyA/hqdefault.jpg?sqp=-oaymwEmCKgBEF5IWvKriqkDGQgBFQAAiEIYAdgBAeIBCggYEAIYBjgBQAE=&rs=AOn4CLBxzdJpO4mcK_0pCFYPYTaXG3OniQ',
        siteIcon:
            'https://www.youtube.com/s/desktop/4981804c/img/logos/favicon_144x144.png',
        link: 'https://www.youtube.com/watch?v=okqC1Q5aEyA',
      ),
    ));
    fetchStreams(); // Load first page
  }

  Future<void> fetchStreams() async {
    if (isLoading.value) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 5));

    final startIndex = (currentPage - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    paginatedStream.addAll(allstreams.sublist(startIndex,
        endIndex > allstreams.length ? allstreams.length : endIndex));
    currentPage++;
    isLoading.value = false;
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      fetchStreams();
    }
  }

  void resetPagination() {
    currentPage = 1;
    paginatedStream.clear();
    fetchStreams();
  }

  void searchItems(String query) {
    if (query.isEmpty) {
      resetPagination();
    } else {
      searchResults.assignAll(
        allstreams.where((stream) =>
            stream.platform.toLowerCase().contains(query.toLowerCase()) ||
            stream.title.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
}
