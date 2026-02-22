import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_utilities.dart';
import '../../../../core/network/endpiont.dart';
import '../../../../ui/test/model.dart';
import '../models/requestProduct_model.dart';
import '../models/responseProduct_model.dart';

abstract class AddProductsRepo {
  Future<NetworkResponse> addProducts({
    required  RequestProductModel requestProductModel,
  });

}
class AddProductsRepoImpl extends AddProductsRepo {
  final ApiHelper apiHelper;

  AddProductsRepoImpl(this.apiHelper);

  @override
  Future<NetworkResponse> addProducts({
    required RequestProductModel requestProductModel,
  }) async {
    return apiHelper.apiCall<ResponseProductModel>(
      addProduct,
      requestType: RequestType.post,
      body: requestProductModel.toJson(),
      sessionToken: "dummyToken",
      headers: {"Custom-Header": "CustomValue"},
      mapper: (json) => ResponseProductModel.fromJson(json),
    );
  }
}