import 'package:get/get.dart';
import 'package:stream_management_flutter/view/create_stream_screen.dart';
import 'package:stream_management_flutter/view/live_stream_screen.dart';
import 'package:stream_management_flutter/view/update_stream_screen.dart';

class Routes {
  static const String home = '/';
  static const String liveStream = '/live-stream';
  static const String createStream = '/create-stream';
  static const String editStream = '/edit-stream';

  static approutes() => [
        GetPage(
          name: home,
          page: () => const LiveStreamsScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: createStream,
          page: () => const CreateStreamScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: editStream,
          page: () => const StreamUpdateScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
      ];
}
