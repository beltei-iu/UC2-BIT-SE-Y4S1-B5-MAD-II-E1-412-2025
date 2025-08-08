import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/model/book.dart';

class BookController extends GetxController {
  var books = <Book>[].obs;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String bookRef = "books";

  Future<void> fetchBooks() async {
    try {
      final dataSnapshot = await _database.ref(bookRef).get();
      print("Data : ${dataSnapshot.value}");
    } catch (error) {
      print("Error : $error");
    }
  }

  Future<void> addBook(Book book) async {
    try {
      await _database.ref(bookRef).push().set(book.toMap());
    } catch (error) {
      print("Error : $error");
    }
  }
}
