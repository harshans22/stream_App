import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_management_flutter/view_model/controllers/create_stream_controller.dart';

import '../models/stream_model.dart';
import '../view_model/controllers/stream_controller.dart';

class CreateStreamScreen extends StatelessWidget {
  const CreateStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createStreamController = Get.put(UpdateStreamController());
    final liveStreamController=Get.put(LiveStreamController());

    return Scaffold(
      backgroundColor: const Color(0xFF050D10),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050D10),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Stream',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      title: 'Streaming / Video Link',
                      hintText: 'Paste your streaming link',
                      onChanged: (String value) {
                        createStreamController.onInputChange(value);
                      },
                      controller: createStreamController.linkController.value,
                    ),
                    const SizedBox(height: 24),

                    _buildDropdownField(
                      title: 'Select your Streaming Platform',
                      value: 'Youtube',
                      items: ['Youtube', 'Twitch', 'Facebook', 'Roster'],
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 24),

                    _buildInputField(
                        title: 'Video / Stream Title',
                        hintText: 'Enter your Stream Title',
                        onChanged: (value) {
                          createStreamController.titleController.value.text = value;
                        },
                        controller:
                            createStreamController.titleController.value),
                    const SizedBox(height: 24),

                    // GamersXTag Logo
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
                          return createStreamController
                                  .thumbnailController.value.isEmpty
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
                                  createStreamController
                                      .thumbnailController.value,
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
          // Bottom Buttons
          Row(
            children: [
              Expanded(
                child: _buildButton(
                  text: 'CANCEL',
                  onPressed: () => Navigator.pop(context),
                  isCancel: true,
                 
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildButton(
                  text: 'PUBLISH',
                  onPressed: () {
                    final stream = StreamModel(
                      title: createStreamController.titleController.value.text,
                      platform: createStreamController.platformController.value.text,
                      thumbnail: createStreamController.thumbnailController.value,
                      siteIcon: createStreamController.siteIconController.value,
                      link: createStreamController.linkController.value.text,
                    );
                    liveStreamController.addStream(stream);
                    Navigator.pop(context);
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
