class Product {
  String? name;
  String? quantity;
  String? image;
  String? price;

  Product({this.name, this.quantity, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    image = json['image'];
     price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name!;
    data['quantity'] = quantity!;
    data['image'] = image!;
    data['price'] = price!;
    return data;
  }
}
