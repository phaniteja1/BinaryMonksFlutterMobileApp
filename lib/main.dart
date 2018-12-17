// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Import other views
import 'pages/home/home.dart';
import 'pages/feeds/feeds.dart';
import 'pages/channels/channels.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Binary Monks",
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.rss_feed)),
                  Tab(icon: Icon(Icons.settings)),
                ],
              ),
            title: Text("Binary Monks"),
            ),
            body: TabBarView(
            children: [
              HomeScreen(),
              FeedsAsync(),
              Channels(),
            ],
          ),
          ),
        ));
  }
}
