import '../../domain/entities/responseProduct.dart';

class RequestProductModel extends ResponseProduct {
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