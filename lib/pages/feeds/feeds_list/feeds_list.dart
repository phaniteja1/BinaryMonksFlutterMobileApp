import 'package:flutter/material.dart';
import '../models/feed.dart';
import 'feeds_list_item.dart';

class FeedsList extends StatelessWidget {
  final _feedsModel;
  final Function onReadMoreTapped;

  FeedsList(this._feedsModel, {@required this.onReadMoreTapped});

  @override
  Widget build(BuildContext context) {
    var feedsList = new ListView.builder(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _feedsModel != null ? _feedsModel.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(child: new Column(children: _buildFeedsList())),
          );
        });
    return new Scaffold(body: feedsList, backgroundColor: Colors.grey[200]);
  }

  List<FeedsListItem> _buildFeedsList() {
    if (_feedsModel != null) {
      List<FeedModel> feedsList =
          List<FeedModel>.from(_feedsModel.map((i) => FeedModel.fromJson(i)));

      return feedsList
          .map((feed) => new FeedsListItem(feed, onReadMoreTapped))
          .toList();
    } else {
      return [];
    }
  }
}
