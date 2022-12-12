import 'package:delverplace/src/model/product.dart';

class Lead {
  int? id;
  String? tracking;
  String? name;
  String? phone;
  String? phone2;
  String? city;
  String? address;
  String? price;
  List<Product>? products;
  String? statusLivrison;

  Lead(
      {this.id,
      this.tracking,
      this.name,
      this.phone,
      this.phone2,
      this.city,
      this.address,
      this.price,
      this.products,
      this.statusLivrison});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tracking = json['tracking'];
    name = json['name'];
    phone = json['phone'];
    phone2 = json['phone2'];
    city = json['city'];
    address = json['address'];
    price = json['price'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    statusLivrison = json['status_livrison'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['tracking'] = tracking;
    data['name'] = name;
    data['phone'] = phone;
    data['phone2'] = phone2;
    data['city'] = city;
    data['address'] = address;
    data['price'] = price;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['status_livrison'] = statusLivrison;
    return data;
  }
}
