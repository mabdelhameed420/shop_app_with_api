class ChangeCartModel {
  bool status;
  String message;
  Data data;

  ChangeCartModel(this.status, this.message, this.data);

  factory ChangeCartModel.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final message = json['message'];
    final data = Data.fromJson(json['data']);
    return ChangeCartModel(status, message, data);
  }
}

class Data {
  int id;
  int quantity;
  Product? product;

  Data(this.id, this.quantity, this.product);

  factory Data.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final quantity = json['quantity'];
    final product = Product.fromJson(json['product']);
    return Data(id, quantity, product);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  Product(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
