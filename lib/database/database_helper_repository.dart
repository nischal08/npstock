import 'package:hive/hive.dart';
import 'package:npstock/data/database_keys.dart';

class DatabaseHelperRepository {
  deleteTicket(String name) async {
    var box = await Hive.openBox(DatabaseBoxId.stock);
    box.delete(DatabaseBoxKeys.ticket);
  }

  addTicket(String name) async {
    var box = await Hive.openBox(DatabaseBoxId.stock);

    List<String>? allItem =await getAllTicket();
    if (allItem == null) {
      await box.put(DatabaseBoxKeys.ticket, [name]);
    } else {
      await box.put(DatabaseBoxKeys.ticket, [allItem, name]);
    }
  }

  dynamic getAllTicket() async {
    var box = await Hive.openBox(DatabaseBoxId.stock);
    box.get(DatabaseBoxKeys.ticket, defaultValue: null);
  }
}
