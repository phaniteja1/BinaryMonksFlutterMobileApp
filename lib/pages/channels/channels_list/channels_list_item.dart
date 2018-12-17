import 'package:flutter/material.dart';
import '../models/channel.dart';

class ChannelsListItem extends StatelessWidget {
  final ChannelModel _feedItem;
  final List<String> _userChannels;

  // actions
  final _addChannelAction;
  final _removeChannelAction;

  ChannelsListItem(this._feedItem, this._userChannels, this._addChannelAction, this._removeChannelAction);

  @override
  Widget build(BuildContext context) {
    final addChannelButton = FlatButton(
      child: const Text('ADD CHANNEL', style: TextStyle(color: Colors.green),),
      onPressed: () =>_addChannelAction(_feedItem.channel),
    );

    final removeChannelButton = FlatButton(
      child: const Text('REMOVE CHANNEL', style: TextStyle(color: Colors.red),),
      onPressed: () => _removeChannelAction(_feedItem.channel),
    );

    var displayButton = FlatButton(
      child: const Text('LOADING...'),
      onPressed: _doNothing,
    );

    if (_userChannels != null) {
      displayButton = _userChannels.indexOf(_feedItem.channel) != -1
          ? removeChannelButton
          : addChannelButton;
    }

    return Center(
        child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            // leading: Icon(Icons.album),
            title: Text(_feedItem.title),
          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[displayButton],
            ),
          ),
        ],
      ),
    ));
  }

  void _doNothing() {

  }
}
