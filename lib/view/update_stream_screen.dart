import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_management_flutter/view/widgets/delete_stream_dialog.dart';
import 'package:stream_management_flutter/view_model/controllers/create_stream_controller.dart';

import '../models/stream_model.dart';
import '../resources/routes.dart';
import '../view_model/controllers/stream_controller.dart';

class StreamUpdateScreen extends StatelessWidget {
  const StreamUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final controller = Get.put(UpdateStreamController());
    final streamController = Get.find<LiveStreamController>();

    controller.setAllControllers(arguments);
    final index = int.parse(Get.parameters['index']!);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Update Stream',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => DeleteStreamDialog(
                        onConfirm: () {
                          streamController.deleteStream(index);
                          Get.offAllNamed(Routes.liveStream);
                        },
                      ));
              // DeleteStreamDialog(
              //   onConfirm: () {
              //     streamController.deleteStream(index);
              //     Get.back();
              //   },
              //   onClose: () {
              //     Get.back();
              //   },
              // );
            },
            // icon: SvgPicture.asset('assets/images/delete_icon.svg',)
            icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Color(0xFF273133),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 230, 228, 228),
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: const Icon(Icons.delete_outlined, color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInputField(
                      title: 'Streaming / Video Link',
                      hintText: 'Enter your Stream URL',
                      onChanged: (value) {
                        controller.onInputChange(value);
                      },
                      //controller: TextEditingController(text: arguments['url']),
                      controller: controller.linkController.value,
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                      title: 'Platform',
                      value: "YouTube",
                      items: ['YouTube', 'Twitch', 'Facebook', 'Other'],
                      onChanged: (value) {
                        // Handle platform change
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      title: 'Title',
                      hintText: 'Enter your Stream Title',
                      onChanged: (value) {
                        //controller.titleController.value.text = value;
                      },
                      controller: controller.titleController.value,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: const Color.fromARGB(255, 241, 240, 240),
                            width: 1.5,
                          ),
                        ),
                        child: Obx(() {
                          return controller.thumbnailController.value.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No Thumbnail',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Image.network(
                                  controller.thumbnailController.value,
                                  fit: BoxFit.cover,
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildButton(
                  text: 'CANCEL',
                  onPressed: () => Get.back(),
                  isCancel: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildButton(
                  text: 'UPDATE',
                  onPressed: () {
                    streamController.updateStream(
                        index,
                        StreamModel(
                          platform: controller.platformController.value.text,
                          title: controller.titleController.value.text,
                          thumbnail: controller.thumbnailController.value,
                          siteIcon: controller.siteIconController.value,
                          link: controller.linkController.value.text,
                        ));
                    Get.back();
                  },
                  isCancel: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String title,
    required String hintText,
    required Function(String) onChanged,
    required controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),

      color: const Color(0xFF2E2E2E), // Background color

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label Text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            color: Colors.black,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500, // Semi-bold text
              ),
            ),
          ),
          const SizedBox(height: 2),
          // Input Text Field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF202020),
            ),
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              style: const TextStyle(
                color: Colors.white, // Text color
                fontSize: 16,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade500, // Hint text color
                  fontSize: 14,
                ),
                border: InputBorder.none, // No visible border
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      color: const Color(0xFF2E2E2E),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            color: Colors.black,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500, // Semi-bold text
              ),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              border: Border.all(
                color: const Color.fromARGB(255, 175, 174, 174),
                width: 1,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: const Color(0xFF111111),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.arrow_drop_down, color: Colors.white),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required bool isCancel,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isCancel
                ? const Color.fromARGB(232, 216, 214, 214)
                : const Color(0xFFDC1A22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color:
                  isCancel ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
