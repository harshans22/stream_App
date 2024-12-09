import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils {
  bool isValidUrl(String url) {
    const urlPattern =
        r'^(https?:\/\/)?([\w\d-]+)\.([\w\d-]+)\.?([\w\d-]+)?(\/.+)?$';
    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  // static Future<Map<String, String>> fetchMetadata(String url) async {
  //   final apiKey = "97734465-793c-4086-a528-77ed4032db55"; // Replace with your OpenGraph API key
  //   try {
  //      final encodedUrl = Uri.encodeComponent(url);
  //      print(encodedUrl);
  //     final response = await http.get(Uri.parse(
  //         'https://opengraph.io/api/1.1/site/$encodedUrl?accept_lang=auto&app_id=$apiKey'));
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return {
  //         "platform": data["hybridGraph"]["site_name"] ?? "Unknown Platform",
  //         "title": data["hybridGraph"]["title"] ?? "Untitled Stream",
  //         "thumbnail": data["hybridGraph"]["image"] ?? "",
  //       };
  //     }
  //     print(response.body);
  //     return <String, String>{};
  //   } catch (e) {
  //     print(e);
  //     throw Exception(e);
  //   }
  // }
}
