import 'package:flutter/material.dart';
import '../models/channel.dart';
import 'channels_list_item.dart';

class ChannelsList extends StatelessWidget {
  final _feedsModel;
  final _userChannels;

  // actions
  final _addChannelAction;
  final _removeChannelAction;

  ChannelsList(this._feedsModel, this._userChannels, this._addChannelAction, this._removeChannelAction);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _feedsModel != null ? _feedsModel.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: new Center(child: new Column(children: _buildChannelsList())),
          );
        });
  }

  List<ChannelsListItem> _buildChannelsList() {
    print(_userChannels);
    if (_feedsModel != null) {
      List<ChannelModel> channelsList =
          List<ChannelModel>.from(_feedsModel.map((i) => ChannelModel.fromJson(i)));
      return channelsList.map((feed) => new ChannelsListItem(feed, _userChannels, _addChannelAction, _removeChannelAction)).toList();
    } else {
      return [];
    }
  }
}
