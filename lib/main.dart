import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'resources/routes.dart';
import 'view_model/controllers/stream_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LiveStreamController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      getPages: Routes.approutes(),
    );
  }
}