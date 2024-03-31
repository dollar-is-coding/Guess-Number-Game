import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'GuessNumber.db';

  static int get version => _version;
  static String get dbName => _dbName;

  static Future<Database> getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), DatabaseHelper.dbName),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE Number (id INTEGER PRIMARY KEY AUTOINCREMENT, numberA INTEGER NOT NULL, numberB INTEGER NOT NULL, numberC INTEGER NOT NULL, numberD INTEGER NOT NULL, rightNumber INTEGER NOT NULL, rightPosition INTEGER NOT NULL, isShow INTEGER NOT NULL, correctNumber TEXT NOT NULL)');
        db.execute(
            'CREATE TABLE Result (id INTEGER PRIMARY KEY AUTOINCREMENT, date DATE NOT NULL, win INTEGER NOT NULL, lose INTEGER NOT NULL, pass INTEGER NOT NULL)');
      },
      version: DatabaseHelper.version,
    );
  }
}
