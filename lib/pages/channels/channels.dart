import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anotherflutter/utils/shared_prefs.dart';

import 'channels_list/channels_list.dart';

void main() {
  runApp(new MaterialApp(
    home: new Channels(),
  ));
}

// Create a stateful widget
class Channels extends StatefulWidget {
  @override
  ChannelsState createState() => new ChannelsState();
}

// Create the state for our stateful widget
class ChannelsState extends State<Channels> {
  List data;
  List userChannels;

  Future<String> fetchChannels() async {
    final response = await http.get(getUrl());

    final userChannelsFromPrefs =
        await SharedPrefs.getFromPrefs('userChannels');

    if (this.mounted) {
      // To modify the state of the app, use this method
      setState(() {
        // Get the JSON data
        var dataConvertedToJSON = json.decode(response.body);
        // Extract the required part and assign it to the global variable named data
        data = dataConvertedToJSON;
        userChannels = userChannelsFromPrefs;
      });
    }
    return 'Successful';
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChannelsList(
            data, userChannels, _addChannelAction, _removeChannelAction));
  }

  String getUrl() {
    // skipCount = this.page * this.pageItems;
    final String baseUrl =
        "https://api.mlab.com/api/1/databases/binarymonks/collections/channels?apiKey=8MsekOtzEDmxaPSSnqqCNJ9KM1XKN2RL";
    return baseUrl;
  }

  void _addChannelAction(String channelSlug) {
    print('Add channel');
    var newChannels = userChannels;
    newChannels.add(channelSlug);
    SharedPrefs.saveToPrefs('userChannels', newChannels);
    if (this.mounted) {
      setState(() {
        userChannels = newChannels;
      });
    }
  }

  void _removeChannelAction(String channelSlug) {
    print('Remove channel');
    var newChannels = userChannels;
    newChannels.remove(channelSlug);
    SharedPrefs.saveToPrefs('userChannels', newChannels);
    if (this.mounted) {
      setState(() {
        userChannels = newChannels;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Call the getJSONData() method when the app initializes
    this.fetchChannels();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
