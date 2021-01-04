// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:quizotic/screens/search.dart';
import 'package:quizotic/screens/settings.dart';

import 'favorites.dart';
import 'list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key, this.restorationId}) : super(key: key);

  final String restorationId;

  @override
  Widget build(BuildContext context) {
    return RestorationScope(
      restorationId: restorationId,
      child: CupertinoTabScaffold(
        // restorationId: 'scaffold',
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'My Garden',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ]),
        tabBuilder: (context, index) {
          if (index == 0) {
            return ListScreen(restorationId: 'list');
          } else if (index == 1) {
            return FavoritesScreen(restorationId: 'favorites');
          } else if (index == 2) {
            return SearchScreen(restorationId: 'search');
          } else {
            return SettingsScreen(restorationId: 'settings');
          }
        },
      ),
    );
  }
}
