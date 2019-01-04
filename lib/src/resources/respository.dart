import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

final _newsDbProvider = NewsDbProvider();
final _newsApiProvider = NewsApiProvder();

class Repository {

  List<Source> sources = <Source>[
    _newsDbProvider,
    _newsApiProvider,
  ];

  List<Cache> caches = <Cache>[
    _newsDbProvider,
  ];

  // Iterate over sources when dbProvider
  // get fetchTopIds is implemented
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}