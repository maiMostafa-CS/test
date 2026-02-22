import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_utilities.dart';
import '../../../../core/network/endpiont.dart';
import '../models/ products_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<NetworkResponse> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiHelper apiHelper;

  ProductRemoteDataSourceImpl(this.apiHelper);

  @override
  Future<NetworkResponse> getProducts() async {
    final response = await apiHelper.apiCall<ProductsResponseModel>(
      products,
      requestType: RequestType.get,
      sessionToken: "dummyToken",
      headers: {"Custom-Header": "CustomValue"},
      mapper: (json) => ProductsResponseModel.fromJson(json),
    );

    return response;
  }
}

