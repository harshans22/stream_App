import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_management_flutter/models/stream_model.dart';

import '../resources/routes.dart';
import '../view_model/controllers/stream_controller.dart';

class LiveStreamsScreen extends StatelessWidget {
  const LiveStreamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LiveStreamController>();

    return Scaffold(
      backgroundColor: const Color(0xFF050D10),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Live Streams',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _buildSearchBar(
              onSearch: (String query) {
                controller.searchItems(query);
              },
              searchController: controller.searchController.value,
            ),
            Expanded(
              child: Obx(
                () => _buildStreamsList(
                  list: controller.searchController.value.text.isNotEmpty
                      ? controller.searchResults
                      : controller.paginatedStream,
                  scrollController: controller.scrollController,
                  isLoading: controller.isLoading.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar({
    required Function(String) onSearch,
    required TextEditingController searchController,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  border: Border.all(color: Colors.white, width: 1)),
              child: TextField(
                controller: searchController,
                onChanged: (value) => onSearch(value),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search for Videos',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.createStream);
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: Colors.red,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreamsList(
      {required List<StreamModel> list,
      required ScrollController scrollController,
      required bool isLoading}) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: list.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < list.length) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(Routes.editStream,
                  arguments: list[index],
                  parameters: {'index': index.toString()});
            },
            child: _buildStreamCard(
              thumbnail: list[index].thumbnail,
              title: list[index].title,
              siteIcon: list[index].siteIcon,
            ),
          );
        } else {
          // Loading indicator
          return Center(
            child: Image.asset("assets/images/gamer_loader.gif",
                width: 200, height: 50, fit: BoxFit.cover),
          );
        }
      },
    );
  }

  Widget _buildStreamCard(
      {required String thumbnail,
      required String title,
      required String siteIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
          ),
          child: Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  image: DecorationImage(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: ClipPath(
                  clipper: LiveStreamTextClipper(),
                  child: Container(
                   
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: const Text(
                      '    LIVE NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    gradient: RadialGradient(colors: [
                  Color.fromARGB(255, 27, 27, 27),
                  Color.fromARGB(255, 57, 56, 56),
                ])),
                child: Image.network(
                  siteIcon,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  height: 50,
                  decoration: BoxDecoration(
                    // gradient: RadialGradient(

                    //   colors: [
                    //   const Color(0xFF000000),
                    //   Color(0xFF1E5E08).withOpacity(0.8),
                    // ])
                    color: const Color(0xFF1E5E08).withOpacity(0.8),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LiveStreamTextClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(10, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
