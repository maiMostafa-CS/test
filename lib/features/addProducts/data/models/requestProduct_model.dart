import 'package:flutter_application_1/features/addProducts/domain/entities/requestProduct.dart';

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