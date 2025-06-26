import 'package:mad_2_412/model/book.dart';
import 'package:mad_2_412/data/sqflite_db_data.dart';
import 'package:sqflite/sqflite.dart';

class BookService {

  Future<void> insertBook(Book book) async{
    // Get Constant DB
    final db = await SqfliteDbData.instance.database;
    // Insert Data
    db.insert(DBConstant.bookTable, book.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Book>> getBooks() async {
    // Get Constant DB
    final db = await SqfliteDbData.instance.database;
    // Get Data
    final List<Map<String, dynamic>> results = await db.query(DBConstant.bookTable);

    // Option 1
    //  List<Book> books = List.generate(results.length, (index) {
    //   return Book.fromMap(results[index]);
    // });

    // Option 2
    List<Book> books = results.map((e) => Book.fromMap(e)).toList();
    return books;
  }


}