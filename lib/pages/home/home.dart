// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:anotherflutter/utils/shared_prefs.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var data;

  void fetchPost() async {
    final response = await http.get(getUrl());
    if (this.mounted) {
      setState(() {
        // Get the JSON data
        var dataConvertedToJSON = json.decode(response.body);
        // Extract the required part and assign it to the global variable named data
        data = dataConvertedToJSON;
      });
    }

    if (await SharedPrefs.getFromPrefs('userChannels') == null) {
      SharedPrefs.saveToPrefs('userChannels', ['slash_dot']);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeMessageView = Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Text(
        "Welcome to Binary Monks",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    Widget infoView = Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Text(
          "Binary Monks gives you programming news from sources you love. Click on 'Feed' to see the news and 'Channels' to select your sources",
          textAlign: TextAlign.center,
        ));

    Widget gifView = JumpingDotsProgressIndicator(
      fontSize: 20.0,
    );

    if (data != null) {
      gifView = Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data != null ? "${data['title']}" : "",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ),
        Image(
          image: new NetworkImage(data != null ? data['link'] : ''),
          fit: BoxFit.cover,
        )
      ]);
    }

    return new Scaffold(
        body: ListView(padding: const EdgeInsets.all(20.0), children: [
      welcomeMessageView,
      infoView,
      gifView,
    ]));
  }

  String getUrl() {
    return 'https://coding-love-random-gif-mxhgjogjpf.now.sh/gif';
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }
}
