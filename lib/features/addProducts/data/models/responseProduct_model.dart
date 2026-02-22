import '../../domain/entities/responseProduct.dart';

class ResponseProductModel extends ResponseProduct{
  ResponseProductModel({
    required super.title,
    required super.description,
    required super.price,
    required super.brand});
  factory ResponseProductModel.fromJson(Map<String, dynamic> json) {
    return ResponseProductModel(
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 0.0,
      brand: json['brand'] ?? 'No brand',
    );
  }
}