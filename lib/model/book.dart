import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

class Book {
  int? id;
  String? title;
  String? author;
  String? description;
  Double? price;
  int? discount;

  Book({
    this.id,
    this.title,
    this.author,
    this.description,
    this.price,
    this.discount,
  });
}
