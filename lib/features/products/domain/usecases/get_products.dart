
import '../../../../core/usecases/base_usecase.dart';
import '../../data/models/products_response_model.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts implements FetchUseCase<List<Product>> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<List<Product>> call() async {
    final response = await repository.getProducts();
    final data = response.data;
    if (data == null) return [];
    if (data is ProductsResponseModel) {
      return data.products ?? [];
    }

    if (data is Map<String, dynamic>) {
      final model = ProductsResponseModel.fromJson(data);
      return model.products ?? model.products ?? [];
    }

    if (data is List) {
      try {
        return data.cast<Product>();
      } catch (_) {
        return [];
      }
    }

    return [];
  }
}