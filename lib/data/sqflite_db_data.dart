import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDbData {

  String dbName = "book.db";

  static final SqfliteDbData instance = SqfliteDbData._();

  SqfliteDbData._();

  Future<Database> get database async {
    // get Path
    final dbPath = await getDatabasesPath();

    // get path of database
    final pathDB = join(dbPath, dbName);

    // check db exist path
    final exist = await databaseExists(pathDB);
    if (!exist) {
      print("Error : Create Database");
    }
    return await openDatabase(pathDB, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {

    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textType = "TEXT";
    final doubleType = "DOUBLE";
    final integerType = "INTEGER";

    String bookSql = ''' 
     CREATE TABLE ${DBConstant.bookTable}(
         id $idType,
         title $textType,
         author $textType,
         description $textType,
         price $doubleType,
         discount $integerType
     )
    ''';
    db.execute(bookSql);

    _onCreateOrderTable(db, version);
  }

  Future<void> _onCreateOrderTable(Database db, int version) async {

  }
}



class DBConstant {

  static final String bookTable = "book";

}
