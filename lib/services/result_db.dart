import 'package:intl/intl.dart';
import 'package:number_game/models/result_model.dart';
import 'package:number_game/services/db_helper.dart';

class ResultDB {
  static Future<List<ResultModel>?> getLatestDate() async {
    final db = await DatabaseHelper.getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Result',
      orderBy: 'id DESC',
      limit: 1,
    );
    if (maps.isEmpty) return [];
    return List.generate(
        maps.length, (index) => ResultModel.fromJson(maps[index]));
  }

  static Future<List<ResultModel>?> getNow() async {
    final db = await DatabaseHelper.getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Result',
      where: 'date = ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(DateTime.now())],
    );
    if (maps.isEmpty) return [];
    return List.generate(
        maps.length, (index) => ResultModel.fromJson(maps[index]));
  }

  static Future<List<ResultModel>> getFiveLatestDate() async {
    final db = await DatabaseHelper.getDB();
    List<Map<String, dynamic>> maps = await db.query(
      'Result',
      orderBy: 'id DESC',
      limit: 5,
    );
    if (maps.isEmpty) {
      return [];
    } else {
      maps = maps.reversed.toList();
    }
    return List.generate(
        maps.length, (index) => ResultModel.fromJson(maps[index]));
  }

  static Future<int> addDate(ResultModel resultModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.insert('Result', resultModel.toJson());
  }

  static Future<int> updateDate(ResultModel resultModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.update(
      'Result',
      resultModel.toJson(),
      where: 'date = ?',
      whereArgs: [resultModel.date],
    );
  }
}
