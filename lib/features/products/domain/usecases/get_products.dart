import 'package:flutter_application_1/features/products/domain/entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    final response = await repository.getProducts();
    return response.products;
  }
}