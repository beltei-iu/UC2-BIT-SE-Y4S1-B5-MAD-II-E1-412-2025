class Book {
  String? id;
  String? title;
  String? author;
  String? description;
  double? price;
  int? discount;

  Book({
    this.id,
    this.title,
    this.author,
    this.description,
    this.price,
    this.discount,
  });

  // Option 1
  // Map<String,dynamic> toMap(){
  //   return {
  //     'id': id,
  //     'title': title,
  //     'author': author,
  //     'description': description,
  //     'price': price,
  //   };
  // }

  // Option 2
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'author': author,
    'description': description,
    'price': price,
  };

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      author: map['author']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : 0.0,
      discount: (map['discount'] is num) ? (map['discount'] as num).toInt() : 0,
    );
  }
}
