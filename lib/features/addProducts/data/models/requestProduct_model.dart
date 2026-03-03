import '../../domain/entities/requestProduct.dart';

/// Data-layer model that extends the domain [RequestProduct] entity.
/// Adds JSON serialization — the domain entity stays clean.
class RequestProductModel extends RequestProduct {
  RequestProductModel({
    required super.title,
    required super.description,
    required super.price,
    required super.brand,
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