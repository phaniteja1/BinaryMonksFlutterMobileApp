
class FeedModel {
  final String title;
  final String summary;
  final String channel;
  final String link;

  const FeedModel({this.title, this.summary, this.channel, this.link});

  factory  FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      title: json['title'],
      summary: json['summary'],
      channel: json['channel'],
      link: json['link'],
    );
  }
}
