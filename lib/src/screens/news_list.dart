import 'package:flutter/material.dart';
import 'dart:async';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return Container(
              padding: EdgeInsets.all(16.0),
              color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
              child: snapshot.hasData ?
                Text('I\'m resolved $index') :
                Text('I haven\'t resolved yet!'),
            );
          }
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(Duration(seconds: 2), () => 'hi');
  }
}