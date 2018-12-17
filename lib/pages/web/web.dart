// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebScreen extends StatefulWidget {
  @override
  WebScreenState createState() => new WebScreenState();
}

class WebScreenState extends State<WebScreen> {
  bool showBottomBar;
  void setInitialState() {
    if (this.mounted) {
      setState(() {
        showBottomBar:
        false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(145.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Samples background text',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () => _launchWebView(),
                ),
              ],
            )),
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
    //
  }

  _launchWebView() {
    if (this.mounted) {
      setState(() {
        showBottomBar = true;
      });
    }
    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.launch(
      'https://flutter.io',
      rect: new Rect.fromLTWH(
        0.0,
        MediaQuery.of(context).size.height / 5.5,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - 250,
      ),
    );
  }

  _closeWebView() {
    if (this.mounted) {
      setState(() {
        showBottomBar = false;
      });
    }
    final flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.close();
  }

  void dispose() {
    super.dispose();
    _closeWebView();
  }

  @override
  void initState() {
    super.initState();
    setInitialState();
  }
}
