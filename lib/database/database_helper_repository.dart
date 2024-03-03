import 'package:hive/hive.dart';
import 'package:npstock/data/database_keys.dart';

class DatabaseHelperRepository {
  deleteTicker(String name) async {
    var box = await Hive.openBox(DatabaseBoxId.stock);
    box.delete(DatabaseBoxKeys.Ticker);
  }

  addTicker(String name) async {
    var box = await Hive.openBox(DatabaseBoxId.stock);

    List<String>? allItem = await getAllTicker();
    if (allItem == null) {
      await box.put(DatabaseBoxKeys.Ticker, [name]);
    } else {
      await box.put(DatabaseBoxKeys.Ticker, [...allItem, name]);
    }
  }

  Future<dynamic> getAllTicker() async {
    var box = await Hive.openBox(DatabaseBoxId.stock);
    return await box.get(DatabaseBoxKeys.Ticker, defaultValue: null);
  }
}
