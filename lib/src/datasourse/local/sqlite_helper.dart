import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelpr {
  static late Database db;

  static Future<Database> createDatabase() async {
    String path = join(await getDatabasesPath(), 'scoresDb');
    print('Create DB');
    db = await openDatabase(path, version: 1, onCreate: (db, verion) {
      db.execute(
          'CREATE TABLE scores(id INTEGER PRIMARY KEY, date TEXT, socre INTEGER)');
      print('Create tabale');
    });

    return db;
  }

//insert scores
  static Future<int> insertScore(
      {required String date,required int score}) async {
    return await db.rawInsert('INSERT INTO scores(date,socre)VALUES("$date","$score")');
  }

//get scores
  static Future<List<Map<String, dynamic>>> getAllScores() async {
    return await db.rawQuery('SELECT * FROM scores ORDER BY date DESC');
  }
}
