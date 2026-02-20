import '../../core/network/api_helper.dart';
import '../../core/network/api_utilities.dart';
import '../../core/network/endpiont.dart';
import 'model.dart';

class ProductsRepo{
  final ApiHelper apiHelper;

  ProductsRepo(this.apiHelper);

  Future<NetworkResponse> getDelegates({
    required RequestProduct delegatesRequestBody,
  }) async {
    return apiHelper.apiCall<ResponseProduct>(
      addProduct,
      requestType: RequestType.post,
      body: delegatesRequestBody.toJson(),
      sessionToken: "dummyToken",
      headers: {"Custom-Header": "CustomValue"},
      mapper: (json) => ResponseProduct.fromJson(json),
    );
  }
}