import '../../../../core/network/api_helper.dart';
import '../../data/models/requestProduct_model.dart';
import '../../data/models/responseProduct_model.dart';
import '../repositories/addProductsRepositories.dart';

class AddProducts {
  final AddProductsRepository repository;

  AddProducts(this.repository);

  Future<NetworkResponse> call({
    required RequestProductModel requestProductModel,
  }) {
    return repository.addProducts(requestProductModel: requestProductModel);
  }
}