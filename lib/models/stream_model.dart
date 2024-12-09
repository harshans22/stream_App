// models/stream_model.dart
class StreamModel {
  String platform;
  String title;
  String thumbnail;
  String siteIcon;
  String link;

  StreamModel({
    required this.platform,
    required this.title,
    required this.thumbnail,
    required this.siteIcon,
    required this.link,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) {
    return StreamModel(
      platform: json['platform'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      siteIcon: json['favicon'],
      link: json['link'],
    );
  }

  //create to string
  @override
  String toString() {
    return 'StreamModel{platform: $platform, title: $title, thumbnail: $thumbnail, siteIcon: $siteIcon}';
  }
}
