import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/stories_provider.dart';

class NewsList extends StatelessWidget {
  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Still waiting on Ids');
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            return Container(
              padding: EdgeInsets.all(16.0),
              color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
              child: snapshot.data[index].hasData ?
                Text(snapshot.data[index.toString()]) :
                Text('I\'m still waiting to resolve'),
            );
          },
        );
        
      }
    );
  }
}