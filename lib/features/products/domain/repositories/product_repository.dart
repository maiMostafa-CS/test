import '../../../../core/network/api_helper.dart';
import '../../data/models/ products_response_model.dart';
import '../entities/ products_response.dart';

abstract class ProductRepository {
  Future<NetworkResponse> getProducts();
}