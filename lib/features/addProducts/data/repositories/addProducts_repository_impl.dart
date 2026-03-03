import '../../../../core/network/api_helper.dart';
import '../../../../core/network/apis/addProduct.api.dart';
import '../../domain/entities/requestProduct.dart';
import '../../domain/entities/responseProduct.dart';
import '../../domain/repositories/addProductsRepositories.dart';
import '../models/requestProduct_model.dart';
import '../models/responseProduct_model.dart';

/// Concrete implementation of [AddProductsRepository].
/// Lives in the data layer — the only place allowed to know about HTTP.
class AddProductsRepositoryImpl implements AddProductsRepository {
  final ApiHelper apiHelper;

  AddProductsRepositoryImpl(this.apiHelper);

  @override
  Future<ResponseProduct> addProduct(RequestProductModel request) async {
    final response = await apiHelper.apiCall<ResponseProductModel,RequestProductModel>(
      api: AddProductAPI.postProduct,
      body: request,
      mapper: (json) => ResponseProductModel.fromJson(json),
    );
    return response.data!;
  }
}
