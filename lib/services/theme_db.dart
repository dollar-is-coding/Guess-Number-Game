import 'package:number_game/models/theme_model.dart';
import 'package:number_game/services/db_helper.dart';

class ThemeDb {
  static Future<List<ThemeModel>> getTheme() async {
    final db = await DatabaseHelper.getDB();
    List<Map<String, dynamic>> maps = await db.query('Theme');
    if (maps.isEmpty) {
      ThemeModel themeModel = ThemeModel(isLight: 1);
      await db.insert('Theme', themeModel.toJson());
      maps = await db.query('Theme');
    }

    return List.generate(
        maps.length, (index) => ThemeModel.fromJson(maps[index]));
  }

  static Future<int> changeTheme(ThemeModel themeModel) async {
    final db = await DatabaseHelper.getDB();
    return await db.update(
      'Theme',
      themeModel.toJson(),
      where: 'id = ?',
      whereArgs: [themeModel.id],
    );
  }
}
