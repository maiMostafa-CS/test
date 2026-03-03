import '../../data/models/requestProduct_model.dart';
import '../entities/responseProduct.dart';
import '../repositories/addProductsRepositories.dart';
import '../../../../core/usecases/base_usecase.dart';

/// Domain use case — only imports domain entities and repo interface.
/// Zero knowledge of HTTP, API endpoints, or data models.
class AddProducts implements SubmitUseCase<RequestProductModel, ResponseProduct> {
  final AddProductsRepository repository;

  AddProducts(this.repository);

  @override
  Future<ResponseProduct> call(RequestProductModel request) {
    return repository.addProduct(request);
  }
}