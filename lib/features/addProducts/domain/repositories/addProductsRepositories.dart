import '../../../../core/network/api_helper.dart';
import '../../data/models/requestProduct_model.dart';

abstract class AddProductsRepository {
  Future<NetworkResponse> addProducts({
    required RequestProductModel requestProductModel,
  });
}