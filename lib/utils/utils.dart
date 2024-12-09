import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils {
  bool isValidUrl(String url) {
    const urlPattern =
        r'^(https?:\/\/)?([\w\d-]+)\.([\w\d-]+)\.?([\w\d-]+)?(\/.+)?$';
    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }
}
