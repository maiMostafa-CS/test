import '../../../../core/network/api_helper.dart';
import '../../domain/repositories/addProductsRepositories.dart';
import '../datasources/repo.dart';
import '../models/requestProduct_model.dart';

class addProductsRepositoriesImpl extends AddProductsRepository {
  AddProductsRepo addProductsRepo;
  addProductsRepositoriesImpl(this.addProductsRepo);
   @override
  Future<NetworkResponse> addProducts({required RequestProductModel requestProductModel}) async {
    return await addProductsRepo.addProducts(requestProductModel: requestProductModel);
}
}