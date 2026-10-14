class Product {
  final int id, priceKurus;
  final String name, category, description, image;
  const Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.priceKurus,
      required this.description,
      required this.image});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      priceKurus: json['priceKurus'] as int,
      description: json['description'] as String,
      image: json['image'] as String);
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'priceKurus': priceKurus,
        'description': description,
        'image': image
      };
}

String money(int kurus) =>
    '${kurus ~/ 100},${(kurus % 100).toString().padLeft(2, '0')} TL';
