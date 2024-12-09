class AppUrl {
  static const String baseUrl = 'https://opengraph.io/api/1.1/site/';
  static const String apiKey = "97734465-793c-4086-a528-77ed4032db55";

  static String getMetadataUrl(String encodedUrl, String apiKey) {
    return '$baseUrl$encodedUrl?accept_lang=auto&app_id=$apiKey';
  }
}
