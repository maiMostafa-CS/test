import '../../data/models/requestProduct_model.dart';
import '../entities/responseProduct.dart';
import '../entities/requestProduct.dart';

/// Domain-layer contract.
/// Only depends on domain entities — zero knowledge of HTTP or data models.
abstract class AddProductsRepository {
  Future<ResponseProduct> addProduct(RequestProductModel request);
}