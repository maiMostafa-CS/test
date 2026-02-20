class  ResponseProduct {
  final String title;
  final String description;
  final double price;
  final String brand;

  ResponseProduct({
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
  });

  factory ResponseProduct.fromJson(Map<String, dynamic> json) {
    return ResponseProduct(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
      brand: json['brand'] ?? 'No brand',
    );
  }
}
class RequestProduct{
  final String title;
  final String description;
  final double price;
  final String brand;

  RequestProduct({
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'brand': brand,
    };
  }
}
