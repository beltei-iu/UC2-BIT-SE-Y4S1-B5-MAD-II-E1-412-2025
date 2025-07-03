import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDbData {

  String dbName = "book.db";

  static final SqfliteDbData instance = SqfliteDbData._();

  SqfliteDbData._();

  final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
  final textType = "TEXT";
  final doubleType = "DOUBLE";
  final integerType = "INTEGER";
  final boolType = "BOOLEAN";

  Future<Database> get database async {
    // get Path
    final dbPath = await getDatabasesPath();

    // get path of database
    final pathDB = join(dbPath, dbName);

    // check db exist path
    // final exist = await databaseExists(pathDB);
    // if (!exist) {
    //   print("Error : Create Database");
    // }
    return await openDatabase(pathDB, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    _onCreateBookTable(db);
    _onCreateOrderTable(db);
    _onCreateFavoriteTable(db);
  }

  Future<void> _onCreateBookTable(Database db) async{
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
  }

  Future<void> _onCreateOrderTable(Database db) async {
    String orderSql = ''' 
     CREATE TABLE IF NOT EXISTS ${DBConstant.orderTable}(
         id $idType,
         bookId $integerType,
         qty $integerType,
         price $doubleType
     )
    ''';
    db.execute(orderSql);
  }

  Future<void> _onCreateFavoriteTable(Database db) async {
    String favoriteSql = ''' 
     CREATE TABLE IF NOT EXISTS ${DBConstant.favoriteTable}(
         id $idType,
         bookId $integerType,
         liked $boolType
     )
    ''';
    db.execute(favoriteSql);
  }
}



class DBConstant {

  static final String bookTable = "book";
  static final String orderTable = "tbl_order";
  static final String favoriteTable = "tbl_favorite";

}
