import '../../../../core/network/api_helper.dart';


abstract class ProductRepository {
  Future<NetworkResponse> getProducts();
}