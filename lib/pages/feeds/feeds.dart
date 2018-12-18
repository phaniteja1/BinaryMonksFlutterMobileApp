import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anotherflutter/utils/shared_prefs.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'feeds_list/feeds_list.dart';

void main() {
  runApp(new MaterialApp(
    home: new FeedsAsync(),
  ));
}

// Create a stateful widget
class FeedsAsync extends StatefulWidget {
  @override
  FeedsAsyncState createState() => new FeedsAsyncState();
}

// Create the state for our stateful widget
class FeedsAsyncState extends State<FeedsAsync> {
  List data;
  List userChannels;
  bool showBottomBar = false;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  void fetchPost() async {
    final url = await getUrl();
    final response = await http.get(url);
    var dataConvertedToJSON = json.decode(response.body);

    // To modify the state of the app, use this method
    if (this.mounted) {
      setState(() {
        // Get the JSON data
        // Extract the required part and assign it to the global variable named data
        data = dataConvertedToJSON;
        showBottomBar = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FeedsList(data, onReadMoreTapped: _readMoreTapped),
        bottomNavigationBar: showBottomBar
            ? BottomAppBar(
                child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _closeWebView(),
                  ),
                ],
              ))
            : null);
  }

  void _readMoreTapped(context, url) {
    _launchWebView(url);
  }

  _launchWebView(String url) {
    if (this.mounted) {
      setState(() {
        showBottomBar = true;
      });

      flutterWebviewPlugin.launch(
        url,
        rect: new Rect.fromLTWH(
          0.0,
          MediaQuery.of(context).size.height / 5.5,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height - 240,
        ),
      );
    }
  }

  _closeWebView() {
    if (this.mounted && showBottomBar) {
      flutterWebviewPlugin.close();
      setState(() {
        showBottomBar = false;
      });
    }
  }

  Future<String> getUrl() async {
    final userChannelsFromPrefs =
        await SharedPrefs.getFromPrefs('userChannels');
    final String baseUrl =
        "https://api.mlab.com/api/1/databases/binarymonks/collections/feeds?apiKey=8MsekOtzEDmxaPSSnqqCNJ9KM1XKN2RL";
    var query =
        'l=30&sk=0&q={"channel": { \$in: ${json.encode(userChannelsFromPrefs)} }}';
    return "$baseUrl&$query";
  }

  @override
  void dispose() {
    super.dispose();
    _closeWebView();
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }
}
