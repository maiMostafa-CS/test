
import '../base.api.dart';

enum AddProductAPI implements API {
postProduct(path: "products/add", method: Method.post);

const AddProductAPI({
required this.path,
required this.method,
});

@override
final String path;
@override
final Method method;
}
