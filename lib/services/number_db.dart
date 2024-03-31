import 'package:number_game/services/db_helper.dart';
import '../models/number_model.dart';

class NumberDB {
  static Future<List<NumberModel>> getNumbers(String randNumber) async {
    final db = await DatabaseHelper.getDB();
    List<Map<String, dynamic>> maps = await db.query('Number');
    if (maps.isEmpty) {
      NumberModel numberModel = NumberModel(
          numberA: 0,
          numberB: 0,
          numberC: 0,
          numberD: 0,
          rightNumber: 0,
          rightPosition: 0,
          isShow: 0,
          correctNumber: randNumber);
      for (var i = 0; i < 10; i++) {
        await db.insert('Number', numberModel.toJson());
      }
      maps = await db.query('Number');
    }
    return List.generate(
        maps.length, (index) => NumberModel.fromJson(maps[index]));
  }

  static Future<int> updateNumber(NumberModel numberModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.update(
      'Number',
      numberModel.toJson(),
      where: 'id = ?',
      whereArgs: [numberModel.id],
    );
  }
}
