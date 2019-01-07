import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_list_tile.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingListTile();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: item.by == '' ? Text('Deleted') : buildText(item),
            subtitle: Text(item.by),
            contentPadding: EdgeInsets.only(
              left: 16.0 * depth,
              right: 16.0
            ),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = item.text
      .replaceAll('&#x27;', "'")
      .replaceAll('&#x2F;', '/')
      .replaceAll('&quot;', '"')
      .replaceAll('&gt', '>')
      .replaceAll('<p>', '\n\n')
      .replaceAll('</p>', '');

    return Text(text);
  }
}