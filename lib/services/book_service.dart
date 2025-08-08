import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mad_2_412/model/book.dart';
import 'package:mad_2_412/data/sqflite_db_data.dart';
import 'package:sqflite/sqflite.dart';

class BookService {
  final _db = FirebaseDatabase.instance;
  String _ref = "article";

  Future<void> insertBook(Book book) async {
    // Get Constant DB
    final db = await SqfliteDbData.instance.database;
    // Insert Data
    db.insert(
      DBConstant.bookTable,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Book>> getBooks() async {
    // Get Constant DB
    final db = await SqfliteDbData.instance.database;
    // Get Data
    final List<Map<String, dynamic>> results = await db.query(
      DBConstant.bookTable,
    );

    // Option 1
    //  List<Book> books = List.generate(results.length, (index) {
    //   return Book.fromMap(results[index]);
    // });

    // Option 2
    List<Book> books = results.map((e) => Book.fromMap(e)).toList();

    return books;
  }

  Future<List<Book>> getBooksFromFirebase() async {
    try {
      final DatabaseReference dbRef = await FirebaseDatabase.instance.ref(
        'books',
      );
      final DatabaseEvent event = await dbRef.once();

      if (event.snapshot.value == null) return [];

      // Step 1 : Convert to Map<dynamic, dynamic>
      final Map<dynamic, dynamic> rawMap =
          event.snapshot.value as Map<dynamic, dynamic>;
      print("RawMap : $rawMap");

      // Step 2 : Convert to Map<String, dynamic>
      final Map<String, dynamic> dataMap = rawMap.map(
        (key, value) => MapEntry(key.toString(), value),
      );
      print("DataMap : $dataMap");

      // Step 3 : Convert to List<Map<String, dynamic>>
      List listMap = dataMap.entries.map((e) {
        // Convert to Map<String, dynamic>
        final map = Map<String, dynamic>.from(e.value as Map);
        // keep Firebase key as ID
        map["id"] = e.key;
        return map;
      }).toList();
      print("ListMap : $listMap");

      List<Book> books = listMap.map((e) => Book.fromMap(e)).toList();
      print("Books : ${books}");
      return books;
    } catch (e) {
      print("Error : $e");
      throw ("Error $e");
    }
  }
}
