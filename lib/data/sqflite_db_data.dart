import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDbData {
  String dbName = "book.db";

  static final SqfliteDbData instance = SqfliteDbData._();

  static final Database? _database;

  SqfliteDbData._();

  Future<Database> get database async {
    // get Path
    final path = await getDatabasesPath();

    // get path of database
    final pathDB = join(path, dbName);

    // check db exist path
    final exist = await databaseExists(pathDB);
    if (!exist) {
      print("Error : Create Database");
    }

    return await openDatabase(pathDB, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {}
}
