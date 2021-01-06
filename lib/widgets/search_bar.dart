// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar({
    @required this.controller,
    @required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = CupertinoTheme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Styles.searchBackground(themeData),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Icon(
                    CupertinoIcons.search,
                    color: Styles.searchIconColor,
                  ),
                ),
                Expanded(
                  child: CupertinoTextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: null,
                    style: Styles.searchText(themeData),
                    cursorColor: Styles.searchCursorColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.clear();
                  },
                  child: Icon(
                    CupertinoIcons.clear_thick_circled,
                    semanticLabel: 'Clear search terms',
                    color: Styles.searchIconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
      ),
    );
  }
}
