

class Order {

  int? id;
  int? bookId;
  int? qty;
  double? price;

  Order({this.id, this.bookId, this.qty, this.price});

  // Write to Table
  Map<String, dynamic> toMap() => {
      "id": id,
      "bookId": bookId,
      "qty": qty,
      "price": price
    };

  // Read from Table
  factory Order.fromMap(Map<String, dynamic> map) => Order(
      id: map["id"],
      bookId: map["bookId"],
      qty: map["qty"],
      price: map["price"]);

}