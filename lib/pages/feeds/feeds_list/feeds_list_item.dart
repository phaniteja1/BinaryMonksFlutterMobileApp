import 'package:flutter/material.dart';
import '../models/feed.dart';

class FeedsListItem extends StatelessWidget {
  final FeedModel _feedItem;
  final Function _onReadMoreTapped;

  FeedsListItem(this._feedItem, this._onReadMoreTapped);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            // leading: Icon(Icons.album),
            title: Text(
              _feedItem.title,
              maxLines: 2,
            ),
            subtitle: Text(
              _feedItem.summary,
              maxLines: 3,
            ),
          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                Text('source: ${_feedItem.channel}',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
                FlatButton(
                  child: const Text('READ MORE'),
                  onPressed: () =>
                      _onReadMoreTapped(context, this._feedItem.link),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
