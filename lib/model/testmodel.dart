class GenderMap {
  final Map<String, CategoryMap> genderMap;

  GenderMap({required this.genderMap});

  factory GenderMap.fromJson(Map<String, dynamic> json) {
    Map<String, CategoryMap> genderMap = {};
    json.forEach((key, value) {
      genderMap[key] = CategoryMap.fromJson(value);
    });
    return GenderMap(genderMap: genderMap);
  }
}

class CategoryMap {
  final Map<String, TypeMap> categoryMap;

  CategoryMap({required this.categoryMap});

  factory CategoryMap.fromJson(Map<String, dynamic> json) {
    Map<String, TypeMap> categoryMap = {};
    json.forEach((key, value) {
      categoryMap[key] = TypeMap.fromJson(value);
    });
    return CategoryMap(categoryMap: categoryMap);
  }
}

class TypeMap {
  final Map<String, List<ProductDetails>> typeMap;

  TypeMap({required this.typeMap});

  factory TypeMap.fromJson(Map<String, dynamic> json) {
    Map<String, List<ProductDetails>> typeMap = {};
    json.forEach((key, value) {
      List<ProductDetails> productList = [];
      value.forEach((product) {
        productList.add(ProductDetails.fromJson(product));
      });
      typeMap[key] = productList;
    });
    return TypeMap(typeMap: typeMap);
  }
}

class ProductDetails {
  final String id;
  final String name;
  final String gender;
  final String brand;
  final String price;
  final List<String> imageUrl;
  final String time;
  final String size;
  final String quantity;
  final String color;

  ProductDetails({
    required this.id,
    required this.name,
    required this.gender,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.time,
    required this.size,
    required this.quantity,
    required this.color,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      brand: json['brand'],
      price: json['price'],
      imageUrl: List<String>.from(json['imageUrl']),
      time: json['time'],
      size: json['size'],
      quantity: json['quantity'],
      color: json['color'],
    );
  }
}
