
class ChannelModel {
  final String title;
  final String channel;

  const ChannelModel({this.title, this.channel});

  factory  ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      title: json['title'],
      channel: json['channel'],
    );
  }
}
