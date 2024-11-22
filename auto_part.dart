class AutoPart {
  final String? id;  // Сделаем id опциональным
  String name;
  String description;
  String imageUrl;
  double price;

  AutoPart({
    this.id,  // id теперь может быть null для нового товара
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory AutoPart.fromJson(Map<String, dynamic> json) {
    return AutoPart(
      id: json['id'], 
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
