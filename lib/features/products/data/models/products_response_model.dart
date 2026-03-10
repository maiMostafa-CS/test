import 'package:flutter_application_1/features/products/data/models/product_model.dart';
import '../../domain/entities/products_response.dart';


class ProductsResponseModel extends ProductsResponse {
  ProductsResponseModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
  Map<String, Object> toJson() {
    return {
      'products': products.map((e) => (e as ProductModel).toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}
