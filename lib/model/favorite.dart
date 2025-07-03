
import 'package:flutter/cupertino.dart';

class Favorite {

  int? id;
  int? bookId;
  bool? liked;

  Favorite({this.id, this.bookId, this.liked});

  Map<String, dynamic> toMap() =>  {
      'id': id,
      'bookId': bookId,
      'liked': liked
    };

  factory Favorite.fromMap(Map<String, dynamic> map) => Favorite(
        id: map['id'],
        bookId: map['bookId'],
        liked: map['liked'] == 1 ? true : false
      );
}