import '../entities/ products_response.dart';

abstract class ProductRepository {
  Future<ProductsResponse> getProducts();
}