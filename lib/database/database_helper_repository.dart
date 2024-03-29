import 'package:hive/hive.dart';
import 'package:npstock/data/database_keys.dart';

class DatabaseHelperRepository {
  deleteTicker(int index) async {
    var box = await Hive.openBox(DatabaseBoxId.stock);
    List<String>? allItem = await getAllTicker();
    if (allItem != null) {
      await box.delete(DatabaseBoxKeys.ticker);
      allItem.removeAt(index);
      await box.put(DatabaseBoxKeys.ticker, allItem);
    }
  }

  addTicker(String name) async {
    var box = await Hive.openBox(DatabaseBoxId.stock);

    List<String>? allItem = await getAllTicker();
    if (allItem == null) {
      await box.put(DatabaseBoxKeys.ticker, [name]);
    } else {
      await box.put(DatabaseBoxKeys.ticker, [...allItem, name]);
    }
  }

  Future<dynamic> getAllTicker() async {
    var box = await Hive.openBox(DatabaseBoxId.stock);
    return await box.get(DatabaseBoxKeys.ticker, defaultValue: null);
  }
}
