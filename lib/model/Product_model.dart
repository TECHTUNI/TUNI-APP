class Productdetails {
  final String id;
  final String name;
  final String brand;
  final String gender;
  final String price;
  final String time;
  final List<dynamic> imageUrlList;
  final String quantity;
  final String color;
  final List<dynamic> size;
  final String iteam;
  final String design;
  final String type;

  Productdetails({
    required this.id,
    required this.name,
    required this.brand,
    required this.gender,
    required this.price,
    required this.time,
    required this.imageUrlList,
    required this.quantity,
    required this.color,
    required this.size,
    required this.iteam,
    required this.design,
    required this.type,
  });

  factory Productdetails.fromJson(Map<String, dynamic> json) {
    return Productdetails(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      gender: json['gender'] ?? '',
      price: json['price'] ?? '',
      time: json['time'] ?? '',
      imageUrlList: json['imageUrl'] ?? [],
      quantity: json['Quantity'] ?? '',
      color: json['color'] ?? '',
      size: json['size'] ?? [],
      iteam: json['category'] ?? '',
      design: json['type'] ?? '',
      type: json['design '] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'gender': gender,
      'price': price,
      'time': time,
      'imageUrl': imageUrlList,
      'Quantity': quantity,
      'color': color,
      'size': size,
    };
  }
}
